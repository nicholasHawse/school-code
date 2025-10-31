import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import fsolve

def theta_from_beta_mach(beta, M):
    gamma = 1.4  # Ratio of specific heats for air
    beta = np.radians(beta)
    
    def equation(theta, beta, M):
        return np.tan(theta) - 2 * (1 / np.tan(beta)) * ((M**2 * np.sin(beta)**2 - 1) / (M**2 * (gamma + np.cos(2 * beta)) + 2))
    
    theta_initial_guess = np.radians(5)  # Improved initial guess for theta
    theta_solution, info, ier, msg = fsolve(equation, theta_initial_guess, args=(beta, M), xtol=1e-10, full_output=True)
    
    if ier != 1:
        return np.nan  # Return NaN if the solution did not converge
    
    return np.degrees(theta_solution[0])

# Define shock angles and Mach numbers
beta_angles = np.linspace(5, 90, 500)  # Avoid zero to prevent division by zero
Mach_numbers = [1.1, 1.2, 1.3, 1.4, 1.6, 1.8, 2, 2.2, 2.4, 2.7, 3, 4, 6, 8, 15]  # Integer Mach numbers from 1 to 20

# Plotting
fig, ax = plt.subplots(figsize=(10, 6))

for M in Mach_numbers:
    theta_values = [theta_from_beta_mach(beta, M) for beta in beta_angles]
    ax.plot(theta_values, beta_angles, label=f'M = {M}')  # Switch x and y axes

ax.set_xlim(0, 50)
ax.set_ylim(0, 90)
ax.set_xlabel(r'Deflection Angle $\theta$ (degrees)')
ax.set_ylabel(r'Shock Angle $\beta$ (degrees)')
ax.set_title(r'$\theta$-$\beta$-Mach Number Relationship for Oblique Shocks')
ax.legend(title='Mach Number', loc='right')
plt.show()