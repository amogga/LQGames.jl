using LinearAlgebra

# Function to compute the minimum distance from a point to a polyline
function point_line_distance(point, polyline)
    # Generate pairs of consecutive points in the polyline
    polyline_pairs = [(polyline[i], polyline[i + 1]) for i in 1:(length(polyline) - 1)]
    
    # Calculate the minimum distance to each segment, passing `point` to `distance_to_line_segment`
    distances = map(pair -> distance_to_line_segment(pair, point), polyline_pairs)
    return minimum(distances)
end

# Function to compute the distance from a point to a line segment
function distance_to_line_segment(segment, point)
    (p1, p2) = segment
    line_vec = p2 .- p1
    point_vec = point .- p1

    # Compute the projection factor t
    t = dot(point_vec, line_vec) / dot(line_vec, line_vec)

    # Clamp t to be between 0 and 1 to stay within the segment
    t_clamped = max(0.0, min(1.0, t))

    # Closest point on the line segment to the point
    closest_point = p1 .+ t_clamped .* line_vec

    return norm(point .- closest_point)
end