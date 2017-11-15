classdef Turtle
    properties
        x
        y
        heading
        pen_on_paper
        pen
        lps % Lines per second, describes speed
    end

    methods
        function obj = Turtle()
            obj.x = 0;
            obj.y = 0;
            obj.heading = 90;
            obj.pen_on_paper = true;
            obj.pen = Pen(1, 'y');
            obj.lps = 10;
        end

        function obj = forward(obj, distance)
            x2 = obj.x + distance * cosd(obj.heading);
            y2 = obj.y + distance * sind(obj.heading);

            if obj.pen_on_paper
                hold on
                l = line([obj.x x2], [obj.y y2]);
                l.LineWidth = obj.pen.width;
                l.Color = obj.pen.color;
                hold off
                pause(1 / obj.lps);
            end

            obj.x = x2;
            obj.y = y2;
        end

        function obj = rotate(obj, angle)
            obj.heading = mod(obj.heading + angle, 360);
        end


        function obj = penUp(obj)
            obj.pen_on_paper = false;
        end

        function obj = pu(obj)
            obj = obj.penUp();
        end


        function obj = penDown(obj)
            obj.pen_on_paper = true;
        end

        function obj = pd(obj)
            obj = obj.penDown();
        end

        function obj = setPen(obj, myPen)
            obj.pen = myPen;
        end


        % Forward
        function obj = fd(obj, distance)
            obj = obj.forward(distance);
        end


        % Backward
        function obj = backward(obj, distance)
            obj = obj.forward(-distance);
        end

        function obj = bk(obj, distance)
            obj = obj.backward(distance);
        end


        % Turning right
        function obj = right(obj, angle)
            obj = obj.rotate(-angle);
        end

        function obj = rt(obj, angle)
            obj = obj.right(angle);
        end

        % Turning left
        function obj = left(obj, angle)
            obj = obj.rotate(angle);
        end

        function obj = lt(obj, angle)
            obj = obj.left(angle);
        end

        % Goto coordinate
        function obj = goto(obj, x, y)
            obj.x = x;
            obj.y = y;
        end

        function obj = setposition(obj, x, y)
            obj = obj.goto(x, y);
        end


        % Set heading
        function obj = setheading(obj, heading)
            obj.heading = heading;
        end


        % get position
        function [x, y] = position(obj)
            x = obj.x;
            y = obj.y;
        end


        % Return to home
        function obj = home(obj)
            obj.x = 0;
            obj.y = 0;
        end

        % Set speed
        function obj = speed(obj, lps)
            obj.lps = lps;
        end


        % Draw a circle
        function [] = circle(obj, diameter)
            t = obj.speed(1000000);
            t = t.setheading(0);
            for i = 1:360
                t = t.forward(diameter / 114.6);
                t = t.rotate(1);
            end
        end

        function [] = spiral(obj, len)
            t = obj.speed(1000);
            t = t.setheading(0);
            for i = 1:len
                t = t.forward(i);
                t = t.rotate(1);
            end
        end

        function [] = spiral_triangle(obj, len)
            t = obj.speed(3);
            t.setheading(0);
            for i = 1:len
                t = t.forward(i);
                t = t.rotate(120);
            end
        end

        % Draw a ractangle
        function [] = square(obj, x, y, side)
            obj.polygon(x, y, side, 4);
        end

        % Draw a Polygon
        function [] = polygon(obj, x, y, side, numside)
            t = obj;
            t = t.goto(x, y);
            t = t.setheading(0);
            for i = 1:numside
                t = t.fd(side);
                t = t.lt(360 / numside);
            end
        end

        function [] = star(obj, x, y, side, numside)
            t = obj;
            t = t.goto(x, y);
            t = t.setheading(0);
            for i = 1:numside
                t = t.fd(side);
                t = t.rt(180 - 720 / numside);
                t = t.fd(side);
                t = t.lt(180 - 360/ numside);
            end
        end

        function [] = blockT(obj, x, y, size)
            t = obj;
            t = t.goto(x, y);
            t = t.setheading(90); % Upwards
            unit = size / 10;

            t = t.fd(unit * 2);

            % Right
            t = t.rt(90);
            t = t.fd(unit * 1);

            % UP
            t = t.lt(90);
            t = t.fd(unit * 6);

            % Left
            t = t.lt(90);
            t = t.fd(unit * 2);

            % Down
            t = t.lt(90);
            t = t.fd(unit * 1);

            % Left
            t = t.rt(90);
            t = t.fd(unit * 2);

            % up
            t = t.rt(90);
            t = t.fd(unit * 3);

            % Right
            t = t.rt(90);
            t = t.fd(unit * 10);

            % Down
            t = t.rt(90);
            t = t.fd(unit * 3);

            % Left
            t = t.rt(90);
            t = t.fd(unit * 2);

            % Up
            t = t.rt(90);
            t = t.fd(unit * 1);

            % Left
            t = t.lt(90);
            t = t.fd(unit * 2);

            % Down
            t = t.lt(90);
            t = t.fd(unit * 6);

            % Right
            t = t.lt(90);
            t = t.fd(unit * 1);

            % Down
            t = t.rt(90);
            t = t.fd(unit * 2);

            % Left
            t = t.rt(90);
            t.fd(unit * 4);
        end


        function [] = tree(obj, length, depth)
            t = obj;
            if depth > 7
                t.pen = t.pen.setWidth(8);
            else
                t.pen = t.pen.setWidth(depth + 1);
            end

            if depth < 0
                return;
            else
                t = t.forward(length);
                l = t.lt(35);
                r = t.rt(35);
                l.tree(length * 0.7, depth - 1);
                r.tree(length * 0.7, depth - 1);
            end

        end

        function [] = snowflake(obj, length, depth)
            obj = obj.speed(100);
            for i = 1:3
                obj = obj.snowflakeHelper(length, depth);
                obj = obj.lt(120);
            end
        end

        function obj = snowflakeHelper(obj, length, depth)
            if depth < 1
                obj = obj.fd(length);
            else
                obj = obj.snowflakeHelper(length / 3, depth - 1);
                obj = obj.rt(60);
                obj = obj.snowflakeHelper(length / 3, depth - 1);
                obj = obj.lt(120);
                obj = obj.snowflakeHelper(length / 3, depth - 1);
                obj = obj.rt(60);
                obj = obj.snowflakeHelper(length / 3, depth - 1);
            end
        end


    end

end
