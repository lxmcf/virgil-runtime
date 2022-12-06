namespace Virgil {
    public class Component {
        public unowned GameObject object { get; private set; }
        public unowned Transform transform { get; private set; }

        public virtual void start () { }
        public virtual void update () { }
    }
}
