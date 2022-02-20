using System;
using SFML.Audio;
using SFML.Graphics;
using SFML.System;
using SFML.Window;

namespace Utilities{

    public static class Utils{
        public static bool IsColliding(Entity enity1, Entity entity2)
        {
            if (enity1.GetSprite().GetGlobalBounds().Intersects(entity2.GetSprite().GetGlobalBounds()))
            {
                return true;
            }
            
            return false;
            
        }
    }

}