import matplotlib.pyplot as plt
import numpy as np
from scipy.spatial import ConvexHull
# Define the octagon vertices with a radius of 1 and center at (0,0)
vertices = [(1, 0), (np.sqrt(2)/2, np.sqrt(2)/2), (0, 1), (-np.sqrt(2)/2, np.sqrt(2)/2), (-1, 0), (-np.sqrt(2)/2, -np.sqrt(2)/2), (0, -1), (np.sqrt(2)/2, -np.sqrt(2)/2)]

# Generate 25 points between each pair of adjacent vertices
num_points_between_vertices = 50
coords = []
for i in range(len(vertices)):
    start_vertex = vertices[i]
    end_vertex = vertices[(i+1) % len(vertices)]
    x_start, y_start = start_vertex
    x_end, y_end = end_vertex
    x_points = np.linspace(x_start, x_end, num_points_between_vertices, endpoint=False)
    y_points = np.linspace(y_start, y_end, num_points_between_vertices, endpoint=False)
    for x, y in zip(x_points, y_points):
        coords.append((x, y))


# Separate x and y coordinates into separate lists
print(coords)

from scipy.spatial import ConvexHull
hull = ConvexHull(coords)
print(len(hull.vertices))
vertices = [coords[i] for i in hull.vertices]
print(vertices)

x_coords, y_coords = zip(*coords)

# Plot the polygon
plt.plot(x_coords, y_coords, 'bo-')

# Set the x and y limits of the plot
plt.xlim([min(x_coords)-0.5, max(x_coords)+0.5])
plt.ylim([min(y_coords)-0.5, max(y_coords)+0.5])
plt.show()