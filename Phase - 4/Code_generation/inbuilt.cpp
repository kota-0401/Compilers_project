#include <iostream>
#include <cmath>

using namespace std;

struct point {
    float xcor, ycor;
};

struct line {
    point p;
    float slope;

    string equation() {
        float c = p.ycor - (slope * p.xcor);
        return "(" + to_string(slope) + ")x - y + (" + to_string(c) + ") = 0";
    }

    bool is_point(point k) {
        return (((slope * k.xcor)- k.ycor + p.ycor - (slope * p.xcor)) == 0);
    }

    line normal(point q) {
        float normal_slope = -1 / slope;
        line normal_line;
        normal_line.p = q;
        normal_line.slope = normal_slope;
        return normal_line;
    }
};

struct circle {
    point centre;
    float radius;

    string equation() {
        float h = 2 * centre.xcor, k = 2 * centre.ycor, c  = (h * h) + (k * k) - (radius * radius);
        return "x^2 + y^2 - (" + to_string(h) + ")x - (" + to_string(k) + ")y - (" + to_string(-c) + ") = 0";
    }

    bool is_point(point k) {
        float distance_squared = pow(k.xcor - centre.xcor, 2) + pow(k.ycor - centre.ycor, 2);
        return ((distance_squared - (radius * radius)) == 0);
    }

    float eccentricity() {
        return 0.0;
    }

    line normal(point q) {
        float normal_slope = (q.ycor - centre.ycor) / (q.xcor - centre.xcor);
        line normal_line;
        normal_line.p = centre;
        normal_line.slope = normal_slope;
        return normal_line;
    }

    line tangent(point q) {
        float slope = (q.ycor - centre.ycor) / (q.xcor - centre.xcor);
        float tangent_slope = -1 / slope;
        line tangent_line;
        tangent_line.p = q;
        tangent_line.slope = tangent_slope;
        return tangent_line;
    }
};

struct parabola {
    point vertex;
    point focus;
    string equation() {
        if (focus.xcor == vertex.xcor) {
            return "(x - " + to_string(vertex.xcor) + ")^2 = " + to_string(4 * (focus.ycor - vertex.ycor)) + "(y - " + to_string(vertex.ycor) + ")";
        }
        else if (focus.ycor == vertex.ycor) {
            return "(y - " + to_string(vertex.ycor) + ")^2 = " + to_string(4 * (focus.xcor - vertex.xcor)) + "(x - " + to_string(vertex.xcor) + ")";
        }
        return "";
    }

    bool is_point(point k) {
        if (focus.xcor == vertex.xcor) {
            return pow((k.xcor -  vertex.xcor), 2) == (4 * (focus.ycor - vertex.ycor) * (k.ycor - vertex.ycor));
        }
        else if (focus.ycor == vertex.ycor) {
            return pow((k.ycor -  vertex.ycor), 2) == (4 * (focus.xcor - vertex.xcor) * (k.xcor - vertex.xcor));
        }
        return false;
    }

    float eccentricity() {
        return 1.0;
    }

    line normal(point k) {
        float normal_slope;
        if (focus.xcor == vertex.xcor) {
            normal_slope = (2 * (focus.ycor - vertex.ycor)) / (vertex.xcor - k.xcor);
        }
        else if (focus.ycor == vertex.ycor) {
            normal_slope = (vertex.ycor - k.ycor) / (2 * (focus.xcor - vertex.xcor));
        }
        line normal_line;
        normal_line.p = k;
        normal_line.slope = normal_slope;
        return normal_line;
    }

    line tangent(point k) {
        float tangent_slope;
        if (focus.xcor == vertex.xcor) {
            tangent_slope = (k.xcor -  vertex.xcor) / (2 * (focus.ycor - vertex.ycor));
        }
        else if (focus.ycor == vertex.ycor) {
            tangent_slope = (2 * (focus.xcor - vertex.xcor)) / (k.ycor - vertex.ycor);
        }
        line tangent_line;
        tangent_line.p = k;
        tangent_line.slope = tangent_slope;
        return tangent_line;
    }
};
