namespace Virgil {
    public abstract class Script {
        //  Core public methods
        public virtual void start () { } /* Object creation */

        public virtual void update () { }

        public virtual void apply () { } /* On script application to object */

        public virtual void enable () { }
        public virtual void disable () { }
    }
}