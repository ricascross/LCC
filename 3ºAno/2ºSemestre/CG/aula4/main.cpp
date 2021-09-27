
#ifdef __APPLE__
#include <GLUT/glut.h>
#else
//#include <GL/glew.h>
#include <GL/glut.h>
#endif
#define _USE_MATH_DEFINES // always before the include
#include <cmath>
#include <string>
#include <vector>


float alpha = -15.0f, beta = 15.0f, radius2=20.0f;
int timebase, timeR;
float frames, fps;

float slices = 262144.0f, height = 6.0f, radius = 5.0f;

char* fpsString = (char *)(malloc(15 * sizeof(char)));


// verticeCount vai guardar o número total de vértices
GLuint vertices, verticeCount;

void changeSize(int w, int h) {

    // Prevent a divide by zero, when window is too short
    // (you cant make a window with zero width).
    if(h == 0)
        h = 1;

    // compute window's aspect ratio
    float ratio = w * 1.0 / h;

    // Set the projection matrix as current
    glMatrixMode(GL_PROJECTION);
    // Load Identity Matrix
    glLoadIdentity();

    // Set the viewport to be the entire window
    glViewport(0, 0, w, h);

    // Set perspective
    gluPerspective(45.0f ,ratio, 1.0f ,1000.0f);

    // return to the model view matrix mode
    glMatrixMode(GL_MODELVIEW);
}

void createAxis();


void renderScene(void) {

    // clear buffers
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    // set the camera
    glLoadIdentity();

    gluLookAt(radius2*cos(beta)*sin(alpha),radius2*sin(beta),radius2*cos(beta)*cos(alpha),
              0.0,0.0,0.0,
              0.0f,1.0f,0.0f);

    createAxis();

    // put the geometric transformations here

    // put drawing instructions here
    glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);

    /**
     * indica que vertices é o VBO ativo
     * aqui, o tipo de buffer é relevante
     * para arrays com propriedades dos vértices, como as posições, o tipo deve ser GL_ARRAY_BUFFER
     * */
    glBindBuffer(GL_ARRAY_BUFFER, vertices);

    /**
     * define a semântica dos dados no VBO.
     * Ao copiarmos os dados, com função GLBufferData. não passamos nenuma informação sobre
     * a estrutura de dados, neste caso que um vértice contém 3 floats.
     * A função GLBufferData só copia bytes sem associar nenhuma semântica sobre esses bytes.
     * A função GLVertexPointer é usada para fornecer essa semântica (os dois últimos
     * parâmetros não são relevantes para este exemplo)
     * Neste caso estamos a dizer que um vértice é constituído por 3 floats*/
    glVertexPointer(3, GL_FLOAT, 0, 0);

    /**
     * com esta função é realizado o desenho dos triângulos presentes no VBO.
     * O segundo parâmetro indica o vértice inicial e o último o número de vértices a desenhar*/
    glDrawArrays(GL_TRIANGLES, 0, verticeCount);

    // calcula os fps
    frames++;
    timeR = glutGet(GLUT_ELAPSED_TIME);

    if (timeR - timebase > 1000) {
        fps = frames*1000.0/(timeR - timebase);
        timebase = timeR;
        frames = 0;
    }

    sprintf(fpsString, "%.3f", fps);
    glutSetWindowTitle(fpsString);

    // End of frame
    glutSwapBuffers();
}

void createAxis()
{
    glBegin(GL_LINES);
    // X axis in red
    glColor3f(1.0f, 0.0f, 0.0f);
    glVertex3f(0.0f, 0.0f, 0.0f);
    glVertex3f(3.0f, 0.0f, 0.0f);

    // Y axis in green
    glColor3f(0.0f, 1.0f, 0.0f);
    glVertex3f(0.0f, 0.0f, 0.0f);
    glVertex3f(0.0f, 3.0f, 0.0f);

    // Z axis in blue
    glColor3f(0.0f, 0.0f, 1.0f);
    glVertex3f(0.0f, 0.0f, 0.0f);
    glVertex3f(0.0f, 0.0f, 3.0f);
    glEnd();
}

void prepareData(){
    // criar um vetor com as coordenadas dos pontos
    std::vector<float> p;

    float theta = (2*M_PI)/slices;

    for(int i = 0; i <= slices; i++)
    {
        float theta2 = i * theta;

        // circumference bases
        // circumference from above

        //primeiro ponto
        //glColor3f(1.0f, 0.0f,0.0f);
        //glVertex3f(cos(theta2)*radius, height, sin(theta2)*radius);
        p.push_back(cos(theta2)*radius);
        p.push_back(height);
        p.push_back(sin(theta2)*radius);


        //segundo ponto
        //glVertex3f(0.0f,height, 0.0f);
        p.push_back(0.0f);
        p.push_back(height);
        p.push_back(0.0f);

        //terceiro ponto
        //glVertex3f(cos(theta+theta2)*radius, height, sin(theta+theta2)*radius);
        p.push_back(cos(theta+theta2)*radius);
        p.push_back(height);
        p.push_back(sin(theta+theta2)*radius);

        // circumference from bottom

        //primeiro ponto
        //glColor3f(1.0f, 0.0f,0.0f);
        //glVertex3f(cos(theta+theta2)*radius, 0.0f, sin(theta+theta2)*radius);
        p.push_back(cos(theta+theta2)*radius);
        p.push_back(0.0f);
        p.push_back(sin(theta+theta2)*radius);

        //segundo ponto
        //glVertex3f(0.0f,0, 0.0f);
        p.push_back(0.0f);
        p.push_back(0.0f);
        p.push_back(0.0f);

        // terceiro ponto
        //glVertex3f(cos(theta2)*radius, 0.0f, sin(theta2)*radius);
        p.push_back(cos(theta2)*radius);
        p.push_back(0.0);
        p.push_back(sin(theta2)*radius);

        // cylinder trunk
        //glColor3f(0.0f, 1.0f,0.0f);
        // glVertex3f(cos(theta+theta2)*radius, height, sin(theta+theta2)*radius);
        //primeiro ponto
        p.push_back(cos(theta+theta2)*radius);
        p.push_back(height);
        p.push_back(sin(theta+theta2)*radius);

        //segundo ponto
        //glVertex3f(cos(theta+theta2)*radius, 0.0f, sin(theta+theta2)*radius);
        p.push_back(cos(theta+theta2)*radius);
        p.push_back(0.0f);
        p.push_back(sin(theta+theta2)*radius);

        //terceiro ponto
        //glVertex3f(cos(theta2)*radius, height, sin(theta2)*radius);
        p.push_back(cos(theta2)*radius);
        p.push_back(height);
        p.push_back(sin(theta2)*radius);


        //glColor3f(0.0f, 0.0f,1.0f);
        //primeiro ponto
        //glVertex3f(cos(theta2)*radius, 0, sin(theta2)*radius);
        p.push_back(cos(theta2)*radius);
        p.push_back(0);
        p.push_back(sin(theta2)*radius);

        //segundo ponto
        //glVertex3f(cos(theta2)*radius, height, sin(theta2)*radius);
        p.push_back(cos(theta2)*radius);
        p.push_back(height);
        p.push_back(sin(theta2)*radius);

        //terceiro ponto
        //glVertex3f(cos(theta+theta2)*radius, 0.0f, sin(theta+theta2)*radius);
        p.push_back(cos(theta+theta2)*radius);
        p.push_back(0.0f);
        p.push_back(sin(theta+theta2)*radius);

    }

    verticeCount = p.size() / 3;

    // criar o VBO
    // a variável vertices ficará com o valor 1 por ser o primeiro VBO a ser criado
    // Este valor representa o número do "slot" alocado e é usado sempre que nos quisermos referir ao VBO
    glGenBuffers(1, &vertices);

    // copiar o vetor para a placa gráfica
    glBindBuffer(GL_ARRAY_BUFFER, vertices); // define que o VBO com o índice vertices é o VBO ativo

    // copia os dados do vetor para a memória gráfica
    glBufferData(
            GL_ARRAY_BUFFER,    // tipo do buffer, só é relevante na altura do desenho
            sizeof(float) * p.size(),   // tamanho do vetor em bytes
            p.data(),   // os dados do array associado ao vetor
            GL_STATIC_DRAW  // indicativo da utilização (estático e para desenho)
            );
}

// write function to process keyboard events
void keyboard_motion(unsigned char key, int mousex, int mousey)
{
    switch(key)
    {
        case 'a':
            printf("Entrou");
            alpha += 15.0f;
            break;
        case 'd':
            alpha -= 15.0f;
            break;
        case 'w':
            beta += 15.0f;
            break;
        case 's':
            beta -= 15.0f;
            break;
        default:
            break;
    }
    glutPostRedisplay();
}

int main(int argc, char **argv) {

// init GLUT and the window
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
    glutInitWindowPosition(100,100);
    glutInitWindowSize(800,800);
    glutCreateWindow("CG@DI-UM");
    //glewInit();

    timebase = glutGet(GLUT_ELAPSED_TIME);

// Required callback registry
    glutDisplayFunc(renderScene);
    glutReshapeFunc(changeSize);
    glutIdleFunc(renderScene);

    glEnableClientState(GL_VERTEX_ARRAY);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);

    prepareData();



// put here the registration of the keyboard callbacks
    glutKeyboardFunc(keyboard_motion);



//  OpenGL settings
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_CULL_FACE);

// enter GLUT's main cycle
    glutMainLoop();

    return 1;
}