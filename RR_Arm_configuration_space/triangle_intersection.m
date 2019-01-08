function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************

flag = true;

    % returns true if the p1, p1 lie on diffenrent sides of the edge, and false otherwise
    % edge: 2 by 2 array describing line: [(ax,ay);(bx,by)]
    % p1, p2: 1 by 2 array (each), each describes a point
    function FLAG = separate(edge, p1, p2)
        % Described in 3D form, so as to performing cross operation
        edge(:,3) = [0;0]; % [(x1,y1,0);(x2,y2,0)]
        p1(3) = 0; p2(3) = 0; 
        
        v1 = cross(edge(2,:) - edge(1,:), p1 - edge(1,:));
        v2 = cross(edge(2,:) - edge(1,:), p2 - edge(1,:));
        
        if (dot(v1, v2) >= 0)
            FLAG = false;
        else
            FLAG = true;
        end
    end

% Use for constructing edges recurrently
P1(4:5,:) = P1(1:2,:);
P2(4:5,:) = P2(1:2,:);

% Check all edges of first triangle (P1)
for i = 1:3
    edge = [P1(i,:); P1(i+1,:)];
    if separate(edge, P1(i+2,:), P2(i+2,:)) && ~separate(edge, P2(i+2,:), P2(i+1,:)) && ~separate(edge, P2(i+1,:), P2(i,:)) 
        flag = false; return;
    end
end
        
% Check all edges of second triangle (P2)
for i = 1:3
    edge = [P2(i,:); P2(i+1,:)];
    if separate(edge, P2(i+2,:), P1(i+2,:)) && ~separate(edge, P1(i+2,:), P1(i+1,:)) && ~separate(edge, P1(i+1,:), P1(i,:)) 
        flag = false; return;
    end
end
        
% *******************************************************************
end