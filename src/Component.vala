namespace Virgil {
    public class Component {
        public unowned GameObject object { get; private set; }
        public unowned Transform transform { get; private set; }

        public string name;

        public Component () {
            Type type = Type.from_instance (this);

            name = type.name ();
        }

        public virtual void start () { }
        public virtual void update () { }

        public virtual void begin_draw () { }
        public virtual void end_draw () { }
    }
}
