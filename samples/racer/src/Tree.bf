using System;
using Tilengine;

namespace racer
{
	struct Tree_st
	{
		public int depth;
		public int x, y;
		public int8 side;
	}

	class Tree
	{
		public static Actor_st* CreateTree(int x, int y, int8 side)
		{
			Actor_st* actor;
			int index = Actor.GetAvailableActor(1, MAX_ACTOR);

			if (index == -1)
				return null;

			actor = Actor.SetActor(index, 1, 0, 0, 136, 208, => TreeTasks);
			TLN.SetSpriteSet(index, Program.spritesets[SPRITESET_TREES]);
			//TLN_SetFirstSprite (index);
			actor.tree.x = x;
			actor.tree.y = y;
			actor.tree.depth = Z_FAR;
			actor.tree.side = side;

			if (side <= 0)
				actor.tree.x += Program.pan;
			else
				actor.tree.x -= Program.pan;

			return actor;
		}
		
		public static void TreeTasks(Actor_st* actor)
		{
			float scale;
			actor.x = Z_NEAR * actor.tree.x / actor.tree.depth;

			if (actor.tree.side > 0)
				actor.x += 136;
			else
				actor.x = 136 - actor.x;

			actor.y = actor.tree.y / actor.tree.depth - 52;
			scale = (float)Z_NEAR / actor.tree.depth;
			TLN.SetSpriteScaling (actor.index, scale, scale);
			actor.tree.depth -= Program.speed;

			/* finaliza */
			if (actor.tree.depth < 1)
				Actor.ReleaseActor(actor);
		}
		
		public static float CalcPerspective(float u, float u0, float u1, float z, float z0, float z1)
		{
			float a = (u - u0) / (u1 - u0);
			float val = 
				((1 - a) * (u0 / z0) + a * (u1 / z1)) /
				((1 - a) * ( 1 / z0) + a * ( 1 / z1));

			return u0 + val * (u1 - u0);
		}
	}
}
