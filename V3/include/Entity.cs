using System;
using SFML.Audio;
using SFML.Graphics;
using SFML.System;
using SFML.Window;

public abstract class Entity
{
    private Texture Entity_Tex;
    private Sprite Entity_Sprite;
    private float x;
    private float y;

    public Entity(string texturepath)
    {
        Entity_Tex = new Texture(texturepath);
        Entity_Sprite = new Sprite(Entity_Tex);
    }

    public void SetTexture(string texturepath)
    {
        Entity_Tex = new Texture(texturepath);
        Entity_Sprite.Texture = Entity_Tex;
    }

    public void Update()
    {
        Entity_Sprite.Position += new Vector2f(x, y);
    }

    public void SetX(int p_x)
    {
        x = p_x;
    }
    
    public void SetY(int p_y)
    {
        y = p_y;
    }

    public Texture GetTex()
    {
        return Entity_Tex;
    }

    public Sprite GetSprite()
    {
        return Entity_Sprite;
    }

    public float GetX(){
        return Entity_Sprite.GetGlobalBounds().Left;
    }

    public float GetY(){
        return Entity_Sprite.GetGlobalBounds().Top;
    }

    public void moveSprite(Vector2f vector)
    {
        Entity_Sprite.Position += vector;
    }

    public void setSpriteLocation(Vector2f vectot)
    {
        Entity_Sprite.Position = vectot;
    }

    public void SetDefiniteX(int p_x)
    {
        Entity_Sprite.Position = new Vector2f(p_x, Entity_Sprite.Position.Y);
    }
    public void SetDefiniteY(int p_y)
    {
        Entity_Sprite.Position = new Vector2f(Entity_Sprite.Position.X, p_y);
    }
}