function route = GradientBasedPlanner (f, start_coords, end_coords, max_its)
% GradientBasedPlanner : This function plans a path through a 2D
% environment from a start to a destination based on the gradient of the
% function f which is passed in as a 2D array. The two arguments
% start_coords and end_coords denote the coordinates of the start and end
% positions respectively in the array while max_its indicates an upper
% bound on the number of iterations that the system can use before giving
% up.
% The output, route, is an array with 2 columns and n rows where the rows
% correspond to the coordinates of the robot as it moves along the route.
% The first column corresponds to the x coordinate and the second to the y coordinate

[gx, gy] = gradient (-f); % Note from LeeChan: think as 2d grid --> gradient = gradient_operation(-f(x, y))

%%% All of your code should be between the two lines of stars.
% *******************************************************************

robot_pose = start_coords;
route = robot_pose;

its = 0;

while true
    if (its == max_its || norm(end_coords - robot_pose) < 2)
        break;
    end

    % Normalize the gradient vetor
    % gvec: gradient valule of potential function at current robot_pose
    % Note order: horizontal (array index 2), vertical direction (array index 1)
    gvec = [gx(round(robot_pose(2)), round(robot_pose(1))), gy(round(robot_pose(2)), round(robot_pose(1)))];
    normalized_gvec = gvec / norm(gvec);
    
    robot_pose = robot_pose + normalized_gvec; % Successive locations in the route should not be greater than 1.0
    
    route = [route; robot_pose]; 
    its = its + 1;

% *******************************************************************
end
route = double(route);
