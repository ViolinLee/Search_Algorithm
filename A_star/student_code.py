def shortest_path(M,start,goal):
    print("shortest path called")
    import copy
    
    # auxiliary function:compute_f(Map, Path , Goal)
    # "f_value" equals "path cost" plus "estimated distance to goal"
    import math
    
    def compute_f(Map, Path , Goal):
        if len(Path) == 0:
            f_value = 0
        else:
            g = 0.0
            h = 0.0
            
            for i in range(len(Path)-1):
                cur_point  = Map.intersections[Path[i]]
                next_point = Map.intersections[Path[i+1]]
                g += math.sqrt((cur_point[0]- next_point[0])**2 + (cur_point[1] - next_point[1])**2)
        
            path_end_cord = Map.intersections[Path[-1]]
            goal_cord  = Map.intersections[Goal]
            h = math.sqrt((path_end_cord[0]- goal_cord[0])**2 + (path_end_cord[1] - goal_cord[1])**2)
        
            f_value = g + h

        return f_value

    # auxiliary function:choice_path(M,frontier,Goal)
    # choose a path with the minimum f_value from frontier
    def choice_path(M,frontier,Goal):
        if len(frontier) == 1:
            p = list(frontier.values())[0]
        else:
            temp_dict = {}
            for F,P in frontier.items():
                f_value = compute_f(M, P, Goal)
                temp_dict[F] = f_value
            KeyofMin = min(temp_dict, key=temp_dict.get)
            p = frontier[KeyofMin]

        return p

    # implement A* algorithm
    roads_dict = M.roads
    frontier_dict = {start:[start]}
    explored = set()

    search_flag = 1
    while search_flag == 1:
        
        path = choice_path(M,frontier_dict,goal)
        
        s = path[-1]
        del frontier_dict[s]
        explored = explored | set([s])
        
        if s == goal:
            search_flag = 0
        else: 
            for i in roads_dict[s]:
                if i in frontier_dict:
                    temp_path = path[:]
                    temp_path.append(i)
                    # the frontier can hold the waypoint of the final optimization path,
                    # and the bellowing operation make sure it is not ignred.
                    if compute_f(M, frontier_dict[i], goal) > compute_f(M, temp_path, goal):
                        frontier_dict[i] = temp_path
                elif not(i in explored):
                    temp_path1 = path[:]
                    temp_path1.append(i)
                    frontier_dict[i] = temp_path1
            
    return path     
    
