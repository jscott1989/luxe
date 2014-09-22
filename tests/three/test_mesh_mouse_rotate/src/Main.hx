
import luxe.Input;
import luxe.Entity;
import luxe.Vector;

import luxe.Component;
import luxe.components.render.MeshComponent;

class MouseRotate extends Component {

    var dragging : Bool = false;
    var mx : Float = 0;
    var my : Float = 0;
    var smooth : Float = 130;
    var mouse : Vector;
    var reference_rotation : Vector;

    override function init() {

        mouse = new Vector();
        reference_rotation = new Vector();

    } //init

    override function onmousedown(e:MouseEvent) {
        mouse = e.pos;
        dragging = true;
        reference_rotation.x = rotation.x;
        reference_rotation.y = rotation.y;
    }

    override function onmouseup(e:MouseEvent) {

        mouse = e.pos;
        dragging = false;

    } //onmouseup

    override function onmousemove(e:MouseEvent) {

        mouse = e.pos;

    } //onmousemove

    override function update(dt:Float) {

        if(dragging) {

            mx = (Luxe.screen.h / 2 - mouse.y) / smooth;
            my = (Luxe.screen.w / 2 - mouse.x) / smooth;

            rotation.setFromEuler(new Vector(-mx, -my));
            // trace(dt);
        }

    } //update


} //MouseRotate


class Main extends luxe.Game {


    var tower:Entity;


    override function ready() {

        Luxe.camera.view.set_perspective({
            far:1000, near:0.1, aspect:Luxe.screen.w/Luxe.screen.h
        });

            //move up and back a bit
        Luxe.camera.pos.set_xyz(0,0.5,2);

            //create an empty entity
        tower = new Entity({ name:'tower' });

            //attach a mesh component
        var mesh = new MeshComponent({ name:'mesh' });
            mesh.file = 'assets/tower.obj';
            mesh.texture = Luxe.loadTexture('assets/tower.jpg');

        tower.add(mesh);
            //attach a mouse rotate component
        tower.add( new MouseRotate({ name:'rotate' }) );

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update

} //Main
