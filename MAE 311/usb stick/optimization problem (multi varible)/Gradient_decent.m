

x = randn([1 1000]);
y = randn([1 1000]);
z = x+y;

surf(x,y,z)
xlabel('x')
ylabel('y')
zlabel('z')

[fx,fy] = gradient(z,0.2);

x0 = 1;
y0 = -2;
t = (x == x0) & (y == y0);
indt = find(t);
z_grad = [zx(indt) zy(indt)]