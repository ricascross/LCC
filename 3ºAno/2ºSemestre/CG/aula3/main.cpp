#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif
#define _USE_MATH_DEFINES // always before the include
#include <cmath>
#include <string>

float alpha = 15.0f, beta = 15.0f, radius2=20.0f;
int timebase, timeR;
float frames, fps;

char* fpsString = (char *)(malloc(15 * sizeof(char)));

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

void drawCylinder(float radius, float height, int slices){
    float theta = (2*M_PI)/slices;

    glBegin(GL_TRIANGLES);
        //glColor3f(1.0f,1.0f,1.0f);
        for(int i = 0; i <= slices; i++)
        {
            float theta2 = i * theta;

            // circumference bases
            // circumference from above
            glColor3f(1.0f, 0.0f,0.0f);
            glVertex3f(cos(theta2)*radius, height, sin(theta2)*radius);
            glVertex3f(0.0f,height, 0.0f);
            glVertex3f(cos(theta+theta2)*radius, height, sin(theta+theta2)*radius);

            // circumference from bottom
            glColor3f(1.0f, 0.0f,0.0f);
            glVertex3f(cos(theta+theta2)*radius, 0.0f, sin(theta+theta2)*radius);
            glVertex3f(0.0f,0, 0.0f);
            glVertex3f(cos(theta2)*radius, 0.0f, sin(theta2)*radius);

            // cylinder trunk
            glColor3f(0.0f, 1.0f,0.0f);
            glVertex3f(cos(theta+theta2)*radius, height, sin(theta+theta2)*radius);
            glVertex3f(cos(theta+theta2)*radius, 0.0f, sin(theta+theta2)*radius);
            glVertex3f(cos(theta2)*radius, height, sin(theta2)*radius);

            glColor3f(0.0f, 0.0f,1.0f);
            glVertex3f(cos(theta2)*radius, 0, sin(theta2)*radius);
            glVertex3f(cos(theta2)*radius, height, sin(theta2)*radius);
            glVertex3f(cos(theta+theta2)*radius, 0.0f, sin(theta+theta2)*radius);

        }

    glEnd();
}

void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();

	gluLookAt(radius2*cos(beta)*sin(alpha),radius2*sin(beta),radius2*cos(beta)*cos(alpha),
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

    // put the geometric transformations here

    // put drawing instructions here
    glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);
    drawCylinder(5.0f, 6.0f, 262144);

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



// write function to process keyboard events
void keyboard_motion(unsigned char key, int mousex, int mousey)
{
    switch(key)
    {
        case 'a':
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

    timebase = glutGet(GLUT_ELAPSED_TIME);

// Required callback registry 
	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	glutIdleFunc(renderScene);

	
// put here the registration of the keyboard callbacks
    glutKeyboardFunc(keyboard_motion);



//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
