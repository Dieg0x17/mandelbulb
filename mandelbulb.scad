module mandelbulb(
    lado_real=100,
    resolucion=50,
    profundidad=100,
    mandelbrot=false,
    potencia=2,
    cx=0.0,
    cy=0.0,
    cz=0.0,
    r=2,
    all_layers=true,
    inner=true
){
    lado=lado_real/resolucion; // lado del cubo
    
    // Algoritmo de tiempo de escape en esfera 3D con coordenadas polares
    // spherical coords from cartesian
    function get_rad(x,y,z) = sqrt(x*x + y*y + z*z);
    function get_theta(x,y,z) = atan2( sqrt(x*x+y*y), z);
    function get_phi(x,y) = atan2(y, x);

    function get_px(px, py, pz, cx) = (pow(get_rad(px, py, pz), potencia) * sin(get_theta(px,py,pz)*potencia) * cos(get_phi(px,py)*potencia) ) + cx;
    function get_py(px, py, pz, cy) = (pow(get_rad(px, py, pz), potencia) * sin(get_theta(px,py,pz)*potencia) * sin(get_phi(px,py)*potencia)) + cy;
    function get_pz(px, py, pz, cz) = (pow(get_rad(px, py, pz), potencia) * cos(get_theta(px,py,pz)*potencia)) + cz;

    // algoritmo escape recursivo
    function escape(rad=2, px, py, pz, cx, cy, cz, step=0, maxstep) = (get_rad(px, py, pz) < rad && step < maxstep ) ? escape(rad, get_px(px,py, pz, cx), get_py(px, py, pz, cy), get_pz(px, py, pz, cz), cx, cy, cz, step+1, maxstep) : step;

    // Funciones de conversión metrica
    function get_rel(x) = (4.0*x/resolucion)-2; // centra en el cuadrante [-2,2]

    union(){
    for ( x=[0:resolucion])
        for (y=[0:resolucion])
            for (z=[0:resolucion])
            translate([x*lado, y*lado, z*lado])
                if(all_layers){
                    if(inner){
                        if (mandelbrot){
                            if (escape(r, get_rel(x), get_rel(y), get_rel(z), get_rel(x), get_rel(y), get_rel(z), 0, profundidad+1) > profundidad){
                                cube([lado, lado, lado]);
                            }
                        } else {
                            if (escape(r, get_rel(x), get_rel(y), get_rel(z), cx, cy, cz, 0, profundidad+1) > profundidad){
                                cube([lado, lado, lado]);
                            }
                        }
                    }else{
                        if (mandelbrot){
                            if (escape(r, get_rel(x), get_rel(y), get_rel(z), get_rel(x), get_rel(y), get_rel(z), 0, profundidad+1) < profundidad+1){
                                cube([lado, lado, lado]);
                            }
                        } else {
                            if (escape(r, get_rel(x), get_rel(y), get_rel(z), cx, cy, cz, 0, profundidad+1) < profundidad+1){
                                cube([lado, lado, lado]);
                            }
                        }
                    }
                }else{
                    if (mandelbrot){
                        if (escape(r, get_rel(x), get_rel(y), get_rel(z), get_rel(x), get_rel(y), get_rel(z), 0, profundidad+1) == profundidad){
                                cube([lado, lado, lado]);
                        }
                    }else{
                        if (escape(r, get_rel(x), get_rel(y), get_rel(z), cx, cy, cz, 0, profundidad+1) == profundidad){
                                cube([lado, lado, lado]);
                        }
                    }
               }
    }
}

//color("red")
//mandelbulb(
//    lado_real=100,
//    resolucion=50,
//    profundidad=100,
//    mandelbrot=true,
//    potencia=2,
//    cx=0.0,
//    cy=0.0,
//    cz=0.0,
//    r=2,
//    all_layers=true,
//    inner=true
//);

//color("green")
// juliabulb
//mandelbulb(
//    lado_real=100,
//    resolucion=50,
//    profundidad=100,
//    mandelbrot=false,
//    potencia=8,
//    cx=0.5,
//    cy=0.3,
//    cz=0.2,
//    r=2,
//    all_layers=true,
//    inner=true
//);

// 3D Printer
extrusor = 0.1; // 0.1 mm
lado = 10; // 10 mm

color("purple")
mandelbulb(
    lado_real=100,//lado,
    resolucion=100,//lado/extrusor,
    profundidad=20,
    mandelbrot=true,
    potencia=8,
    cx=0.0,
    cy=0.0,
    cz=0.0,
    r=2,
    all_layers=true,
    inner=true
);

