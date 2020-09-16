%File name "Camera2_3to2.m"

% Generate pixel coordinates of a point (or points) in camera 2 image

% input X_s spatial coordinates of a point (or points) in space frame

% output m_c2  pixel coordinates of this point (or these points) in camera 2 image

function m_c2 = Camera2_3to2(X_s)

height = 0.5;

% Set T_s_c2
M4 = [1 0 0 0;
      0 1 0 1;
      0 0 1 height + 0.4;
      0 0 0 1;];
agx = 135*pi/180;
M3 = [      1         0         0       0;
            0  cos(agx) -sin(agx)       0;
            0  sin(agx)  cos(agx)       0;
            0         0         0       1;];
agy = 000*pi/180;
M2 = [cos(agy)        0   sin(agy)       0;
            0         1          0       0;
     -sin(agy)        0   cos(agy)       0;
            0         0          0       1;];
agz = 090*pi/180;
M1 = [cos(agz) -sin(agz)         0       0;
      sin(agz)  cos(agz)         0       0;
            0         0          1       0;
            0         0          0       1;];
agx = 030*pi/180;
M0 = [      1         0         0       0;
            0  cos(agx) -sin(agx)       0;
            0  sin(agx)  cos(agx)       0;
            0         0         0       1;];
T_s_c2 = M4*M3*M2*M1*M0;
T_c2_s = inv(T_s_c2);

% Set a
a = [800    0  800   0;
       0  800  800   0;
       0    0    1   0;];

% Homogenizing 
[r,c]=size(X_s);
X_s_homo = zeros([r,c]+[1,0]);
X_s_homo([1 2 3],:) = X_s;
X_s_homo(4,:) = ones(1,c);

% Pin-hole camera model
m_c2_homo = a*T_c2_s*X_s_homo;

% De-homogenization
m_c2 = zeros(size(m_c2_homo)-[1 0]);
m_c2([1 2],:) = [m_c2_homo(1,:)./m_c2_homo(3,:);
                 m_c2_homo(2,:)./m_c2_homo(3,:);];

end