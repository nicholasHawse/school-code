import math
import sys
try:
    import numpy as np
    import matplotlib.pyplot as plt
    _HAS_MPL = True
except Exception:
    _HAS_MPL = False

#!/usr/bin/env python3
"""
new_script.py

Interactive calculator for Mach number(s) from area ratio A/A* and specific heat ratio gamma.
Computes both subsonic (M < 1) and supersonic (M > 1) solutions of the isentropic area-Mach relation.
"""


def area_ratio(M: float, gamma: float) -> float:
    """Compute A/A* for given Mach M and specific heat ratio gamma."""
    if M <= 0:
        return float("inf")
    term = (1.0 + (gamma - 1.0) / 2.0 * M * M)
    exponent = (gamma + 1.0) / (2.0 * (gamma - 1.0))
    return (1.0 / M) * ( (2.0 / (gamma + 1.0)) * term ) ** exponent

def find_root_bisect(target: float, gamma: float, lo: float, hi: float, tol: float=1e-10, max_iter: int=200) -> float:
    """Bisection root finder for f(M) = area_ratio(M,gamma) - target on [lo, hi].
       Assumes f(lo) and f(hi) have opposite signs."""
    flo = area_ratio(lo, gamma) - target
    fhi = area_ratio(hi, gamma) - target
    if flo == 0.0:
        return lo
    if fhi == 0.0:
        return hi
    if flo * fhi > 0:
        raise ValueError("Bisection endpoints do not bracket a root")
    for _ in range(max_iter):
        mid = 0.5 * (lo + hi)
        fmid = area_ratio(mid, gamma) - target
        if abs(fmid) < tol:
            return mid
        # narrow interval
        if flo * fmid <= 0:
            hi = mid
            fhi = fmid
        else:
            lo = mid
            flo = fmid
        if hi - lo < tol * max(1.0, mid):
            return 0.5 * (lo + hi)
    return 0.5 * (lo + hi)

def solve_mach(area_ratio_target: float, gamma: float):
    if area_ratio_target < 1.0:
        raise ValueError("A/A* must be >= 1.0 for real isentropic solutions.")
    if area_ratio_target == 1.0:
        return 1.0, 1.0

    eps = 1e-12
    # Subsonic root in (0,1)
    lo_sub = 1e-12
    hi_sub = 1.0 - 1e-12
    # f(lo_sub) = +inf - target > 0, f(hi_sub) = 1 - target <= 0 (for target >= 1)
    M_sub = find_root_bisect(area_ratio_target, gamma, lo_sub, hi_sub)

    # Supersonic root in (1, +inf). Find an upper bound where f(high)>0
    lo_sup = 1.0 + 1e-12
    hi_sup = 2.0
    # expand hi_sup until area_ratio(hi_sup) - target > 0
    tries = 0
    while area_ratio(hi_sup, gamma) - area_ratio_target <= 0:
        hi_sup *= 2.0
        tries += 1
        if tries > 100:
            raise RuntimeError("Unable to bracket supersonic root (area grows too slowly).")
    M_sup = find_root_bisect(area_ratio_target, gamma, lo_sup, hi_sup)

    return M_sub, M_sup


def plot_area_vs_mach(gamma: float, target: float = None, M_sub: float = None, M_sup: float = None):
    """Plot area ratio A/A* vs Mach number for given gamma.
    Optionally mark the target A/A* and the sub/supersonic solutions.
    """
    if not _HAS_MPL:
        raise RuntimeError("matplotlib or numpy not available for plotting")

    # choose M range: show subsonic near 0 to 1 and supersonic up to a sensible max
    M_max = 5.0
    if M_sup is not None:
        M_max = max(M_max, float(M_sup) * 1.5)

    # create a non-uniform grid: dense near M=1 where area curve has minimum
    M1 = np.linspace(0.01, 0.9, 300)
    M2 = np.linspace(0.9, 1.1, 400)
    M3 = np.linspace(1.1, M_max, 600)
    M = np.concatenate([M1, M2, M3])

    # vectorized area computation
    vec_area = np.vectorize(lambda m: area_ratio(float(m), float(gamma)))
    A = vec_area(M)

    fig, ax = plt.subplots(figsize=(8, 5))
    ax.plot(M, A, label=f'A/A* (gamma={gamma:g})', color='C0')

    if target is not None:
        ax.axhline(target, color='C3', ls='--', label=f'target A/A* = {target:g}')
    if M_sub is not None:
        ax.axvline(M_sub, color='C1', ls=':', label=f'M_sub = {M_sub:.6g}')
        ax.plot([M_sub], [area_ratio(M_sub, gamma)], 'C1o')
    if M_sup is not None:
        ax.axvline(M_sup, color='C2', ls=':', label=f'M_sup = {M_sup:.6g}')
        ax.plot([M_sup], [area_ratio(M_sup, gamma)], 'C2o')

    ax.set_xlabel('Mach number M')
    ax.set_ylabel('Area ratio A/A*')
    ax.set_yscale('linear')
    ax.set_ylim(bottom=0)
    ax.set_title(f'Isentropic area ratio vs Mach (gamma={gamma:g})')
    ax.grid(True, which='both', ls='--', lw=0.5)
    ax.legend()
    plt.tight_layout()
    return fig, ax

def prompt_float(prompt_text: str, default: float = None) -> float:
    while True:
        try:
            s = input(prompt_text).strip()
            if s == "" and default is not None:
                return default
            val = float(s)
            return val
        except ValueError:
            print("Invalid number, try again.")

def main():
    try:
        print("Isentropic area-Mach calculator")
        A_ratio = prompt_float("Enter area ratio A/A* (>= 1): ")
        gamma = prompt_float("Enter specific heat ratio gamma (e.g. 1.4): ")
        if A_ratio < 1.0:
            print("Error: A/A* must be >= 1. No real solutions.")
            sys.exit(1)
        if gamma <= 1.0:
            print("Error: gamma must be > 1.0")
            sys.exit(1)

        M_sub, M_sup = solve_mach(A_ratio, gamma)
        print(f"\nResults for A/A* = {A_ratio:.6g}, gamma = {gamma:.6g}:")
        print(f"  Subsonic Mach (M < 1):  {M_sub:.10f}")
        print(f"  Supersonic Mach (M > 1): {M_sup:.10f}")
        # Offer to plot if matplotlib is available
        if _HAS_MPL:
            resp = input("\nShow plot of A/A* vs M? [y/N]: ").strip().lower()
            if resp == 'y' or resp == 'yes':
                try:
                    fig, ax = plot_area_vs_mach(gamma, target=A_ratio, M_sub=M_sub, M_sup=M_sup)
                    plt.show()
                except Exception as e:
                    print("Plotting failed:", e)
        else:
            print("Note: matplotlib/numpy not available; skipping plot.")
    except Exception as e:
        print("Error:", e)
        sys.exit(1)

if __name__ == "__main__":
    main()