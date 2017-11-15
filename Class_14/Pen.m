classdef Pen
    properties
        color
        width
    end

    methods
        function obj = Pen(myWidth, myColor)
            if nargin < 2
                myWidth = 1;
                myColor = 'g';
            end
            obj.width = myWidth;
            obj.color = myColor;
        end

        function obj = setColor(obj, myColor)
            obj.color = myColor;
        end

        function obj = setWidth(obj, myWidth)
            obj.width = myWidth;
        end


    end
end
