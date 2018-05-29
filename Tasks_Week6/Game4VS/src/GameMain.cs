using System;
using SwinGameSDK;


namespace MyGame
{
    
    public class GameMain
    {

        const int COLUMNS = 25;
        const int ROWS = 7;
        const int CELL_WIDTH = 51;
        const int CELL_GAP = 0;
        const int MAX_ITEMS = 50;
        const int ITEM_SIZE = 4;
        const int BLOCK_SIZE = 50;

        public struct GameData
        {
            public playerClass ply;
            public Ball.BallData ball;
            public Ball bl;
            public item.itemData[] items;
            public item itm;
            public item item;
            public block.BlockData block;
            public block.BlockData[] blocks;
            public block blk;
            public collision col;
        }

        public GameMain()
        {

        }

        //no need since objects?
        /*public class Game
        {
             public struct GameData
             {
                public Timer time;
                public PlayerData player;
                public BlockArray blocks;
                public BallData ball;
                public BlockGrid grid;
                public itemArray items;
             }
            
        }*/

        public class block
        {
           //block enum
           public enum blockType {soft, hard, items};

            //array for blocks
            //Boolean[0..COLUMNS - 1, 0..ROWS - 1] BlockGrid;
            //Boolean[COLUMNS, ROWS] BlockGrid;
            public bool[,] BlockGrid = new bool[COLUMNS, ROWS];
           


            //record for blockdata
            public struct BlockData
            {
                public blockType kind;
                public Bitmap bmp;
                public int x, y;
                public int score;
                public Color Bcolor;
                public bool itemdrop;
                //public BlockGrid grid;

            }

          // BlockData[] BlockArray;

            public int BlockWidth(BlockData block)
            {
                return SwinGame.BitmapWidth(block.bmp);
            }

            public int BlockHeight(BlockData block)
            {
                return SwinGame.BitmapHeight(block.bmp);
            }

            /////////////////////////////////////
            //sets certain blockTypes to their specific bitmap 

            public Bitmap blockBitmap(blockType kind)
            {
                //kind value;
                switch(kind)
                {
                    case blockType.soft: return SwinGame.BitmapNamed("soft"); 
                    case blockType.hard: return SwinGame.BitmapNamed("hard"); 
                    case blockType.items: return SwinGame.BitmapNamed("item");
                    default: return null;
                }
                          
            }

            ////////////////////////////////////
            //randomly selecting a blockType 
            public blockType RandomBlockType()
            {
                var random = new Random();
                blockType kind = (blockType)random.Next(3);
                return kind;
                               
            }


            ////////////////////////////////////
            //random block creator
            public BlockData RandomBlock()
            {
                BlockData block = new BlockData();

                block.kind = RandomBlockType();
                block.bmp = blockBitmap(block.kind);
                block.Bcolor = SwinGame.RandomColor();
                block.itemdrop = SwinGame.Rnd() > 0.80;

                return block;
            }

            //////////////////////////////////
            //drawing blocks bitmap/Rectangles
            public void FillBlock(BlockData block)
            {
                //bitmap
                SwinGame.DrawBitmap(block.bmp, block.x, block.y);
                //FillRectangle(block.Bcolor, x, y, CELL_WIDTH, CELL_WIDTH);
            }

            ////////////////////////////////
            //checking whether block exists in specific row and column
                                  //might want to change bool parameter to BlockGrid at some point?
            public Boolean isBlock(bool[,] grid, int col, int row)
            {
                return grid[col, row];
            }

            /////////////////////////////
            //SETS UP BLOCKS FOR USE
            //possibly want to add gamedata to parameter?
            public void GenerateBlocks()
            {
                //BlockArray blocks = new BlockArray();
                
                //BlockData[] blocks = new BlockArray();

                //delcaring instance of blockdata arraY
                BlockData[] blocks = new  BlockData[BLOCK_SIZE];

                //might want to include setting length of array
                //pascal code SetLength(game.blocks, numBlocks);

                for(int col = 0; col < COLUMNS; col++)
                {
                    for(int row = 0; row < ROWS; row++)
                    {
                        // Randomly set each cell to true/false
                        
                        BlockGrid[col, row] = SwinGame.Rnd() > 0.5;
             
                        //if the block is set it is randomising the type of block and setting location                                                 
                        if (isBlock(BlockGrid, col, row))
                        {
                            //not assigning game.blocks the random value but executing random value sum
                            blocks[col] = RandomBlock();
                
                            //giving the blocks their x and y positions    
                            blocks[col].x = col * (CELL_WIDTH + CELL_GAP);
                            blocks[row].y = row * (CELL_WIDTH + CELL_GAP);
                        }
                    }
                }
            }





            ////////////////////////////////////////////
            //rendering blocks on screen to update them
            public void DrawBlocks(GameData game)
            {
                BlockData[] blocks = new  BlockData[BLOCK_SIZE];
                
                for(int col = 0; col < COLUMNS; col++)
                {
                    for(int row = 0; row < ROWS; row++)
                    {
                        if (isBlock(BlockGrid, col, row))
                        {
                            FillBlock(game.blocks[col]);
                        }
                    }
                }

            }
            ////////////////////////
            //END OF BLOCK
            ////////////////////////

        }

        ////////////////////////
        //START OF BALL
        ///////////////////////
        public class Ball
        {
          
            public struct BallData
            {
                public Bitmap bmp;
                public float x,y;
                public float dx, dy;
            }

            public int BallWidth(BallData ball)
            {
                return SwinGame.BitmapWidth(ball.bmp);
            }

           public int BallHeight(BallData ball)
           {
               return SwinGame.BitmapHeight(ball.bmp);
           }

            //Instance of ball
            BallData ball = new  BallData();

            ////////////////////////////
            //rendering ball bitmap on screen
            public void drawBall(BallData ball)
            {
                SwinGame.DrawBitmap(ball.bmp, ball.x, ball.y);
            }


            //////////////////////////////////////
            //teleporting player and ball back to center for when ball goes out of bounds
            public void respawnBall(GameData game)
            {
                BallData ball = new BallData();
                //PlayerData player = new PlayerData();
                
                game.ply.player.lives -= 1;

                game.ball.dx = 0;
                game.ball.dy = 0;

                game.ply.player.dx = 0;
                game.ply.player.dy = 0;

                game.ply.player.x = (SwinGame.ScreenWidth() - game.ply.PlayerWidth()) / 2;
                game.ply.player.y = SwinGame.ScreenHeight() - game.ply.PlayerHeight() - 10;


                ball.x = (game.ply.player.x) + (game.ply.PlayerWidth()) / 2 - (BallWidth(ball));
                ball.y = (game.ply.player.y) - (game.ply.PlayerHeight()); 
            }

            ///////////////////////////////////////////
            //setting up balls position, bitmap and acceleration
            public void setUpBall(GameData game)
            {
                game.ball.bmp = SwinGame.LoadBitmap("ball_d.png");

                game.ball.dx = 0;
                game.ball.dy = 0;

                game.ball.x = (game.ply.player.x) + (game.ply.PlayerWidth())/2-(game.bl.BallWidth(game.ball));
                game.ball.y = (game.ply.player.y) - (game.ply.PlayerHeight());
            }

            


        }
        /////////////////////
        //END OF BALL
        /////////////////////

        ///////////////////////
        //START OF ITEM
        ///////////////////////
        public class item
        {
            //item kind
            public enum itemKind {gpaddle, spaddle, gball, sball};
            
            //record
            public struct itemData
            {
                public Bitmap bmp;
                public int x, y;
                public itemKind kind;
            }

            itemData[] itemArray;

            public int itemHeight(itemData item)
            {
                return SwinGame.BitmapHeight(item.bmp);
            }

            public Bitmap itemBitmap(itemKind kind)
            {
                //kind value;
                switch(kind)
                {
                    case itemKind.gpaddle: return SwinGame.BitmapNamed("gpaddle"); 
                    case itemKind.spaddle: return SwinGame.BitmapNamed("spaddle"); 
                    case itemKind.gball: return SwinGame.BitmapNamed("gball");
                    case itemKind.sball: return SwinGame.BitmapNamed("sball");
                    default: return null;
                }
            }
            
            public itemKind RandomItemType()
            {
                var random = new Random();
                itemKind kind = (itemKind)random.Next(ITEM_SIZE);
                return kind;
            }

            public itemData RandomiseItem(int x, int y)
            {
                 itemData item = new itemData();

                item.kind = RandomItemType();
                item.bmp = itemBitmap(item.kind);
                item.x = x;
                item.y = y;

                return item;
            }

            public void UpdateItem(GameData game)
            {
                //itemData[] items = new itemData[MAX_ITEMS];
                for(int i = 0; i < game.items.Length; i++)
                {
                    game.items[i].y += 1;
                }
            }

            public void drawItem(GameData game)
            {
                //itemData[] items = new itemData[MAX_ITEMS];
                for(int i = 0; i < game.items.Length; i++)
                {
                     SwinGame.DrawBitmap(game.items[i].bmp, game.items[i].x, game.items[i].y);
                    //FillRectangle(colorblue, items[i].x, items[i].y, CELL_WIDTH, CELL_WIDTH);
                }
            }
        
            public void initilizeItem()
            {
                /*
                itemData[] items = new itemData[MAX_ITEMS];
                SetLength(game.items, MAX_ITEMS);
    
                game.items[0].x := -50;
                game.items[0].y := -50;
                game.items[0].kind := RandomItemType();
                game.items[0].bmp := itemBitmap(game.items[0].kind);
                */
            }



        
        }
        //////////////////////
        //END OF ITEM
        //////////////////////
        
        ////////////////////////
        //START OF PLAYER
        ////////////////////////
        public class playerClass
        {
            //player struct
            public struct PlayerData
            {
                public string playerName;
                public Single x, y;
                public Single dx, dy;
                public Bitmap bmp;
                public int score;
                public int lives;
            }
            
            //if I do highscores
            PlayerData[] PlayerArray;

            //instance of player
            public PlayerData player = new PlayerData();
        
            public int PlayerWidth()
            {
                return SwinGame.BitmapWidth(player.bmp);
            }
            
            public int PlayerHeight()
            {
                return SwinGame.BitmapHeight(player.bmp);
            }

            //////////////////////////////////////
            //drawing player bitmap
            public void drawPlayer()
            {
                SwinGame.DrawBitmap(player.bmp, player.x, player.y);
            }
            

            /////////////////////////////////////////
            //setting up player acceleration, position, lives and bitmap
            public void setupPlayer()
            {
                player.bmp = SwinGame.LoadBitmap("player_default.png");

                 //position
                player.dx = 0;
                player.dy = 0;
                player.x = (SwinGame.ScreenWidth() - PlayerWidth()) / 2;
                player.y = SwinGame.ScreenHeight() - PlayerHeight() - 10;

                //live/score
                player.score = 0;
                player.lives = 3;
            }

            /////////////////////////////
            //handles player controls
            public void handleInput()
            {
                SwinGame.ProcessEvents();

                if (SwinGame.KeyDown(KeyCode.vk_RIGHT))
                {
                    player.dx += 0.3F;
                }

                if (SwinGame.KeyDown(KeyCode.vk_LEFT))
                 {
                    player.dx -= 0.3F;
                 }

                if (SwinGame.KeyDown(KeyCode.vk_UP))
                {
                     player.dy -= 0.3F;
                }

                if (SwinGame.KeyDown(KeyCode.vk_DOWN))
                {
                     player.dy += 0.3F;
                }
            }



          

        }
        ///////////////////////////
        //END OF PLAYER
        /////////////////////////

        ///////////////////////////
        //START OF COLLISION
        //////////////////////////
        public class collision
        {
            public void PlayerCollisions(GameData game)
            {
                //left
                if (game.ply.player.x >= SwinGame.ScreenWidth() - game.ply.PlayerWidth())
                {
                    game.ply.player.dx = -2;
                    SwinGame.PlaySoundEffect("playerWall");
                }

                //right
                if (game.ply.player.x <= 0)
                {
                    game.ply.player.dx = +2;
                    SwinGame.PlaySoundEffect("playerWall");
                }

                //up
                if (game.ply.player.y <= 400)
                {
                    game.ply.player.dy = +2;
                    SwinGame.PlaySoundEffect("playerWall");
                }

                //down
                if (game.ply.player.y >= SwinGame.ScreenHeight() - game.ply.PlayerHeight())
                {
                    game.ply.player.dy = -2;
                    SwinGame.PlaySoundEffect("playerWall");
                }

                
                 //ball collides with paddle here
                 //if ball is greater than players x pos, stopping ball if left onwards
                if ((game.ply.player.x <= game.ball.x + game.bl.BallWidth(game.ball)) && (game.ball.x <= game.ply.player.x + game.ply.PlayerWidth()))
                {     
                    //top 
                    if (game.ply.player.y <= game.ball.y + game.bl.BallHeight(game.ball))
                    {
                
                        //making sure it isn't below the bottom of the player
                        if (game.ply.player.y + game.ply.PlayerHeight() >= game.ball.y + game.bl.BallHeight(game.ball))
                        {
                            //sends ball up
                            game.ball.dy += -3;
                            SwinGame.PlaySoundEffect("playerBall");
                            
                            //right side
                            if ((game.ply.PlayerWidth() + game.ply.player.x >= game.ball.x + game.bl.BallWidth(game.ball) / 2) && ((game.ply.player.x + (game.ply.PlayerWidth() * (2 / 3))) <= game.ball.x + game.bl.BallWidth(game.ball) / 2))
                            {
                                    game.ball.dx += 2;
                            }
                        
                        
                            //center
                            if ((game.ply.player.x + 1 / 3 * game.ply.PlayerWidth() <= game.ball.x + game.bl.BallWidth(game.ball) / 2) && (game.ply.player.x + 2 / 3 * game.ply.PlayerWidth() >= game.ball.x + game.bl.BallWidth(game.ball) / 2))
                            {
                                game.ball.dx = 0;
                            }

                            //left
                            if ((game.ply.player.x <= game.ball.x + game.bl.BallWidth(game.ball) / 2) && (game.ply.player.x + game.ply.PlayerWidth() * 1 / 3 >= game.ball.x + game.bl.BallWidth(game.ball) / 2))
                            {
                                game.ball.dx -= 2;
                            }
                        }
                           

                        //bottom
                        if (game.ply.player.y + game.ply.PlayerHeight() <= game.ball.y)
                        {
                            //minimum boundary
                            if (game.ply.player.y + game.ply.PlayerHeight() + game.bl.BallHeight(game.ball) / 4 >= game.ball.y)
                            {
                                game.ball.dy += 3;
                                game.ball.dx += 1;
                                SwinGame.PlaySoundEffect("playerBall");
                            }           
                        }
                    }
                }
            }

            ////////////////////////
            //Ball Collisions
            /////////////////////////
            public void ballCollisions(GameData game)
            {
                //left
                if (game.ball.x >= SwinGame.ScreenWidth() - game.bl.BallWidth(game.ball))
                {
                    game.ball.dx = -3;
                    SwinGame.PlaySoundEffect("ballWall");
                }

                //right
                if (game.ball.x <= 0)
                {
                    game.ball.dx = +3;
                    SwinGame.PlaySoundEffect("ballWall");
                }

                //up
                if (game.ball.y <= 0)
                {
                    game.ball.dy = +3;
                    SwinGame.PlaySoundEffect("ballWall");
                }

                //down
                if (game.ball.y >= SwinGame.ScreenHeight() - game.bl.BallHeight(game.ball))
                {
                    //loss of life
                    game.bl.respawnBall(game);
                    SwinGame.PlaySoundEffect("loseLive");
                }
            }

            ///////////////////
            //BLOCK COLLISIONS
            ////////////////////
            public void blockCollisions(GameData game)
            {
                int i = 0;
                for (int col = 0; col < COLUMNS; col++)
                {
                    // For each row
                    for (int row = 0; row < ROWS; row++)
                    {
                        if((game.blocks[col].x + CELL_WIDTH >= game.ball.x) && (game.blocks[col].x <= game.ball.x + game.bl.BallWidth(game.ball)))
                        {
                            if ((game.blocks[row].y + CELL_WIDTH >= game.ball.y) && (game.blocks[row].y <= game.ball.y + game.bl.BallHeight(game.ball)) && (game.blk.BlockGrid[col, row] = true))
                            {
                                game.blk.BlockGrid[col, row] = false;
                                game.ply.player.score += 1;
                                SwinGame.PlaySoundEffect("ballBlock");

                                
                                //if item is true
                                if ((game.blocks[col].itemdrop))
                                {
                                    i+=1;
                                    var random = new Random();
                                
                                    game.items[random.Next(MAX_ITEMS)] = game.item.RandomiseItem(game.blocks[col].x, game.blocks[row].y);
                                }                                       
                            }
                        }
                    }
                }
            }

            public void itemCollision(GameData game)
            {
                for (int i = 0; i < game.items.Length; i++)
                {
                    if ((game.ply.player.x + game.ply.PlayerWidth() >= game.items[i].x) && (game.ply.player.x <= game.items[i].x) && (game.ply.player.y <= game.items[i].y + game.itm.itemHeight(game.items[i])))
                    {
                        SwinGame.PlaySoundEffect("item");
                        game.items[i].x = -50;

                        if (game.items[i].kind == MyGame.GameMain.item.itemKind.gpaddle) { game.ply.player.bmp = SwinGame.LoadBitmap("player_default_1.png"); }
                        if (game.items[i].kind == MyGame.GameMain.item.itemKind.spaddle) { game.ply.player.bmp = SwinGame.LoadBitmap("player_default_2.png"); }
                        if (game.items[i].kind == MyGame.GameMain.item.itemKind.gball) { game.ball.bmp = SwinGame.LoadBitmap("ball_d_1.png"); }
                        if (game.items[i].kind == MyGame.GameMain.item.itemKind.sball) { game.ball.bmp = SwinGame.LoadBitmap("ball_d_2.png"); }
                    }
                }
            }
           
        }
        ////////////////////////
        //END OF COLLISIONS
        ////////////////////////

        //Loading data
        public class updategame
        {
            public void Load()
            {
                SwinGame.LoadBitmapNamed("soft", "soft.png");
                SwinGame.LoadBitmapNamed("hard", "hard.png");
                SwinGame.LoadBitmapNamed("item", "item.png");

                SwinGame.LoadBitmapNamed("gpaddle", "gpaddle.png");
                SwinGame.LoadBitmapNamed("spaddle", "spaddle.png");
                SwinGame.LoadBitmapNamed("gball", "gball.png");
                SwinGame.LoadBitmapNamed("sball", "sball.png");

                SwinGame.LoadBitmapNamed("background", "background.jpg");

                //ball hitting wall
                SwinGame.LoadSoundEffectNamed("ballWall", "ballWall.wav");

                //player hitting ball
                SwinGame.LoadSoundEffectNamed("playerBall", "playerball_1.wav");

                //player hitting wall
                SwinGame.LoadSoundEffectNamed("playerWall", "playerWall.wav");

                //ball hitting blocks
                SwinGame.LoadSoundEffectNamed("ballBlock", "ballblock.wav");

                //player dying
                SwinGame.LoadSoundEffectNamed("loseLive", "loseLive.wav");

                //hitting item
                SwinGame.LoadSoundEffectNamed("item", "item.wav");
            }

            public void handleCollisions(GameData game)
            {
                game.col.PlayerCollisions(game);
                game.col.ballCollisions(game);
                game.col.blockCollisions(game);
                game.col.itemCollision(game);
            }

            public void UpdatePlayer(playerClass play)
            {
                play.handleInput();

                play.player.x += play.player.dx;
                play.player.y += play.player.dy;
            }

            ////////////////////////////////////////
            //updating ball acceleration

            public void UpdateBall(GameData game)
            {
                game.ball.x += game.ball.dx;
                game.ball.y += game.ball.dy;
            }

            public void DisplayGame(GameData game)
            {
                SwinGame.ClearScreen(SwinGame.ColorWhite());
                SwinGame.DrawBitmap("background", 0, 0);
                game.ply.drawPlayer();
                game.bl.drawBall(game.ball);
                game.blk.DrawBlocks(game);
                game.itm.drawItem(game);
                SwinGame.DrawText("Score: " + game.ply.player.score.ToString() + " Lives: " + game.ply.player.lives.ToString(), SwinGame.ColorBlack(), 0, 0);

                SwinGame.RefreshScreen(60);
            }


            //for timers and score collision detections etc
            public void UpdateGame(GameData game)
            {
                SwinGame.ProcessEvents();
                UpdatePlayer(game.ply);
                UpdateBall(game);
                DisplayGame(game);
                handleCollisions(game);
                game.itm.UpdateItem(game);
            }

            //open graphics window etc
            public void SetUpGame(GameData game)
            {
                SwinGame.OpenGraphicsWindow("Blocken", 1280, 720);
                //ShowSwinGameSplashScreen();
                Load();


            //public item.itemData[] items;
            
            
            //public block.BlockData[] blocks;
           


                game.ply.setupPlayer();
                game.bl.setUpBall(game);
                game.blk.GenerateBlocks();

                //initilizeItem();

            }
        }

        
            
        public static void Main()
        {
            GameData game = new GameData();
            updategame update = new updategame();

            game.ply = new playerClass();
            game.bl = new Ball();
            game.ball = new Ball.BallData();
            game.itm = new item();
            game.item = new item();
            game.block = new block.BlockData();
            game.blk = new block();
            game.col = new collision();
          
            update.SetUpGame(game);

            /*
            //Open the game window
            SwinGame.OpenGraphicsWindow("GameMain", 800, 600);
            SwinGame.ShowSwinGameSplashScreen();
            */
             
            //Run the game loop
            while(false == SwinGame.WindowCloseRequested())
            {
                //Fetch the next batch of UI interaction
                SwinGame.ProcessEvents();
                
                update.UpdateGame(game);

                //Clear the screen and draw the framerate
                SwinGame.ClearScreen(Color.White);
                SwinGame.DrawFramerate(0,0);
                
                //Draw onto the screen
                SwinGame.RefreshScreen(60);
            }
        }
    }
}