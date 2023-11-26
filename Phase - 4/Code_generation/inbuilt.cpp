

struct ellipse {
    point centre;
    float a, b;
    string equation() {
        return "(" + to_string(1 / (a * a)) + ")[x - " + to_string(centre.xcor) + "]^2 + (" + to_string(1 / (b * b)) + ")[y - " + to_string(centre.ycor) + "]^2 = 1";
    }

    bool is_point(point k) {
        return ((pow(((k.xcor - centre.xcor) / a), 2) + pow(((k.ycor - centre.ycor) / b), 2)) == 1);
    }

    float eccentricity() {
        if (a > b) {
            return 1 - pow((b / a), 2);
        }
        return 1 - pow((a / b), 2);
    }

    line normal(point k) {
        float normal_slope = pow((b / a), 2) * ((k.ycor - centre.ycor) / (k.xcor - centre.xcor));
        line normal_line;
        normal_line.p = k;
        normal_line.slope = normal_slope;
        return normal_line;
    }

    line tangent(point k) {
        float tangent_slope = pow((a / b), 2) * ((centre.xcor - k.xcor) / (k.ycor - centre.ycor));
        line tangent_line;
        tangent_line.p = k;
        tangent_line.slope = tangent_slope;
        return tangent_line;
    }
};

struct hyperbola {
    point centre;
    float a, b;
    string equation() {
        return "(" + to_string(1 / (a * a)) + ")[x - " + to_string(centre.xcor) + "]^2 - (" + to_string(1 / (b * b)) + ")[y - " + to_string(centre.ycor) + "]^2 = 1";
    }

    bool is_point(point k) {
        return ((pow(((k.xcor - centre.xcor) / a), 2) - pow(((k.ycor - centre.ycor) / b), 2)) == 1);
    }

    float eccentricity() {
        return 1 + pow((b / a), 2);
    }

    line normal(point k) {
        float normal_slope = pow((b / a), 2) * ((k.ycor - centre.ycor) / (centre.xcor - k.xcor));
        line normal_line;
        normal_line.p = k;
        normal_line.slope = normal_slope;
        return normal_line;
    }

    line tangent(point k) {
        float tangent_slope = pow((a / b), 2) * ((k.xcor - centre.xcor) / (k.ycor - centre.ycor));
        line tangent_line;
        tangent_line.p = k;
        tangent_line.slope = tangent_slope;
        return tangent_line;
    }
};

int main() {
    point mypoint;
    mypoint.xcor = 0;
    mypoint.ycor = 0;

    line myLine;
    myLine.p = {1.0, 2.0};
    myLine.slope = 3.0;

    cout << "Equation of the line: " << myLine.equation() << endl;

    point testPoint = {2.0, 5.0};
    cout << "Is the point on the line? " << (myLine.is_point(testPoint) ? "Yes" : "No") << endl;

    line normalLine = myLine.normal({2.0, 5.0});
    cout << "Equation of the normal line: " << normalLine.equation() << endl;

{// Example usage
    circle myCircle;
    myCircle.centre = {1.0, 2.0};
    myCircle.radius = 3.0;

    cout << "Equation of the circle: " << myCircle.equation() << endl;

    point testPoint = {4.0, 2.0};
    cout << "Is the point on the circle? " << (myCircle.is_point(testPoint) ? "Yes" : "No") << endl;

    cout << "Eccentricity of the circle: " << myCircle.eccentricity() << endl;

    line normalLine = myCircle.normal({4.0, 2.0});
    cout << "Equation of the normal line: " << normalLine.equation() << endl;

    line tangentLine = myCircle.tangent({4.0, 2.0});
    cout << "Equation of the tangent line: " << tangentLine.equation() << endl;}

// Example usage for parabola
    parabola myParabola;
    myParabola.vertex = {0.0, 0.0};
    myParabola.focus = {0.0, 1.0};

    cout << "Equation of the parabola: " << myParabola.equation() << endl;

    point testPointPara = {1.0, 1.0};
    cout << "Is the point on the parabola? " << (myParabola.is_point(testPointPara) ? "Yes" : "No") << endl;

    cout << "Eccentricity of the parabola: " << myParabola.eccentricity() << endl;

    line normalLinePara = myParabola.normal({1.0, 1.0});
    cout << "Equation of the normal line for parabola: " << normalLinePara.equation() << endl;

    line tangentLinePara = myParabola.tangent({1.0, 1.0});
    cout << "Equation of the tangent line for parabola: " << tangentLinePara.equation() << endl;

    // Example usage for ellipse
    ellipse myEllipse;
    myEllipse.centre = {0.0, 0.0};
    myEllipse.a = 2.0;
    myEllipse.b = 1.0;

    cout << "Equation of the ellipse: " << myEllipse.equation() << endl;

    point testPointEllipse = {1.0, 0.0};
    cout << "Is the point on the ellipse? " << (myEllipse.is_point(testPointEllipse) ? "Yes" : "No") << endl;

    cout << "Eccentricity of the ellipse: " << myEllipse.eccentricity() << endl;

    line normalLineEllipse = myEllipse.normal({1.0, 0.0});
    cout << "Equation of the normal line for ellipse: " << normalLineEllipse.equation() << endl;

    line tangentLineEllipse = myEllipse.tangent({1.0, 0.0});
    cout << "Equation of the tangent line for ellipse: " << tangentLineEllipse.equation() << endl;

    // Example usage for hyperbola
    hyperbola myHyperbola;
    myHyperbola.centre = {0.0, 0.0};
    myHyperbola.a = 2.0;
    myHyperbola.b = 1.0;

    cout << "Equation of the hyperbola: " << myHyperbola.equation() << endl;

    point testPointHyperbola = {1.0, 0.0};
    cout << "Is the point on the hyperbola? " << (myHyperbola.is_point(testPointHyperbola) ? "Yes" : "No") << endl;

    cout << "Eccentricity of the hyperbola: " << myHyperbola.eccentricity() << endl;

    line normalLineHyperbola = myHyperbola.normal({1.0, 0.0});
    cout << "Equation of the normal line for hyperbola: " << normalLineHyperbola.equation() << endl;

    line tangentLineHyperbola = myHyperbola.tangent({1.0, 0.0});
    cout << "Equation of the tangent line for hyperbola: " << tangentLineHyperbola.equation() << endl;

    return 0;
}
