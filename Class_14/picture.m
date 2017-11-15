SQUARE_COUNT = 7;

MAX_SQUARE_LENGTH = 100;
MIN_SQUARE_LENGTH = 5;
LINE_WIDTH = 1;

COLOR = 'black';


t = Turtle();
t = t.speed(5);
t = t.setPen(Pen(LINE_WIDTH, COLOR));
axis equal

% count = SQUARE_COUNT;
% for i = linspace(MAX_SQUARE_LENGTH, MIN_SQUARE_LENGTH, SQUARE_COUNT)
%     t.pen = t.pen.setWidth(count);
%     t.x = (MAX_SQUARE_LENGTH - i) / 2;
%     t.y = (MAX_SQUARE_LENGTH - i) / 2;
%     for j = 1:4
%         t = t.forward(i);
%         t = t.rotate(-90);
%     end
%     count = count - 1;
% end
% TEST CODES for CHALLENGES UNCOMMENT TO TEST
% figure(1);
% t.spiral_triangle(30);

% pause(1)
% figure(2)
% axis equal
% t.circle(100);
%
% pause(1)
% figure(3)
% axis equal
% t.square(0, 0, 100);
%
% pause(1)
% figure(4)
% axis equal
% t.polygon(0, 0, 10, 8);
%
% pause(1)
% figure(5)
% axis equal
% t.star(0, 0, 10, 7);
%
% pause(1)
% figure(6)
% axis equal
% t.blockT(0, 0, 100);
%
% % CHANGE THE SPEED TO ACCELERATE
% t = t.speed(100);
%
% pause(1)
% figure(7)
% axis equal
% t.tree(1, 8);
%
% t = t.speed(300);
%
% pause(1)
% figure(8)
for i = 1:5
    figure(i);
    axis equal
    t.snowflake(1, i);
end
