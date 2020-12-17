using System;
using System.Collections;
using Tilengine;

namespace racer
{
	struct Rect_st
	{
		public int x1, y1, x2, y2;
	}

	struct Actor_st
	{
		public int index;
		public int type;
		public int state;
		public int w, h;
		public int x, y;
		public int vx, vy;
		public int life;
		public Rect_st hitbox;
		public uint[4] timers;
		public function void(Actor_st*) callback;
		public Tree_st tree;
	}

	class Actor
	{
		/* local variables */
		static List<Actor_st> actors = new .() ~ if (_ !== null) delete _;
		static int count = 0;
		static uint time;

		/* create actors array */
		public static bool CreateActors(int num)
		{
			count = num;

			for (int i = 0; i < num; i++)
				actors.Add(.());

			return true;
		}

		/* delete actors array */
		public static bool DeleteActors()
		{
			actors.Clear();
			delete actors;
			actors = null;
			count = 0;
			return true;
		}

		/* returns index of first available actor (-1 = all used) */
		public static int GetAvailableActor(int first, int len)
		{
			int c, last;

			if (actors == null || count == 0 || count < first)
				return -1;

			last = first + len;

			for (c = first; c < last; c++) {
				if (actors[c].state == 0)
					return c;
			}

			return -1;
		}

		/* gets actor pointer from index */
		public static Actor_st* GetActor(int index)
		{
			if (actors != null && index < count)
				return &actors[index];
			else
				return null;
		}

		/* sets actor properties */
		public static Actor_st* SetActor(int index, int type, int x, int y, int w, int h, function void(Actor_st*) callback)
		{
			if (actors != null && index < count) {
				Actor_st* actor = &actors[index];
				actor.index = index;
				actor.type = type;
				actor.callback = callback;
				actor.state = 1;
				actor.x = x;
				actor.y = y;
				actor.w = w;
				actor.h = h;
				UpdateActorHitbox(actor);
				return actor;
			}

			return null;
		}

		/* releases actor */
		public static void ReleaseActor(Actor_st* actor)
		{
			TLN.SetSpriteBlendMode(actor.index, .None, 0);
			actor.state = 0;
		}

		/* sets collision box */
		public static void UpdateActorHitbox(Actor_st* actor)
		{
			actor.hitbox.x1 = actor.x;
			actor.hitbox.y1 = actor.y;
			actor.hitbox.x2 = actor.x + actor.w;
			actor.hitbox.y2 = actor.y + actor.h;
		}

		/* Periodic tasks */
		public static void TasksActors(uint t)
		{
			int c;

			if (actors == null)
				return;

			time = t;

			for (c = 0; c < count; c++) {
				Actor_st* actor = &actors[c];

				if (actor.state != 0)
					TasksActor(actor);
			}
		}

		/* returns collision between two actors */
		public static bool CheckActorCollision(Actor_st* actor1, Actor_st* actor2)
		{
			return 
				actor1.hitbox.x1 < actor2.hitbox.x2 &&
				actor1.hitbox.x2 > actor2.hitbox.x1 &&
				actor1.hitbox.y1 < actor2.hitbox.y2 &&
				actor1.hitbox.y2 > actor2.hitbox.y1;
		}

		/* sets generic timeout */
		public static void SetActorTimeout(Actor_st* actor, int timer, int timeout)
		{
			actor.timers[timer] = time + (uint)timeout;
		}

		/* gets generic timeout ended */
		public static bool GetActorTimeout(Actor_st* actor, int timer)
		{
			return time >= actor.timers[timer];
		}

		/* TasksActor */
		public static void TasksActor(Actor_st* actor)
		{
			/* motion */
			actor.x += actor.vx;
			actor.y += actor.vy;

			if (actor.callback != null)
				actor.callback(actor);

			/* updates associated sprite */
			if (actor.state != 0) {
				UpdateActorHitbox(actor);
				TLN.SetSpritePosition(actor.index, actor.x, actor.y);
			} else {
				TLN.DisableSprite(actor.index);
				TLN.DisableSpriteAnimation(actor.index);
			}
		}
	}
}
