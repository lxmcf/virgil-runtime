namespace Virgil {
    public class Component {
        public unowned GameObject object { get; internal set; }

        public string name { get; private set; }

        public bool enabled;

        public Component () {
            Type type = Type.from_instance (this);

            name = type.name ();
            enabled = true;
        }

        public virtual void start () { }
        public virtual void update () { }
        public virtual void draw () { }

        public virtual void begin_draw () { }
        public virtual void end_draw () { }

        public virtual void draw_gui () { }
    }
}
