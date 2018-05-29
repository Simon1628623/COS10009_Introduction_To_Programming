using System;
using SwinGameSDK;
using SwinGameSDK.SwinGame;

namespace MyGame
{
    public class GameMain
    {
        
        public static void Main()
        {
            OpenGraphicsWindow("Circle Moving 2 - C#", 800, 600);
            LoadDefaultColors();
            

            int x = 400;
            int y = 300;
            const int CIRCLE_RADIUS = 100;

            do
            {
            ProcessEvents();

            if (KeyDown(VK_LEFT))
            {
                x--;
            }
            if (KeyDown(VK_RIGHT))
            {
                x++;
            }
            if (KeyDown(VK_UP))
            {
                y--;
            }
            if (KeyDown(VK_DOWN))
            {
                y++;
            }


            if  (x >= ScreenWidth())
            {
                x--;
            }

            if (x <= 0)
            {
                x++;
            }

            if (y >= ScreenHeight())
            {
                x--;
            }

            if (y <= 0)
            {
                x++;
            }

            ClearScreen(Color.White);
            FillCircle(Color.Green, x, y, CIRCLE_RADIUS);
            RefreshScreen(60);

            } while(!WindowCloseRequested());

            //Delay(5000);
        }
    }
}

