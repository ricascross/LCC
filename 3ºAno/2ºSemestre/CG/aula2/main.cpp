#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#include <math.h>
#include<stdio.h>

float x = 0.0f;
float y = 0.0f;
float z = 0.0f;
float angle = 0.0f;
float angle2 = 0.0f;
float angle3 = 0.0f;


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

// create axis
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

void make_pyramid()
{
    glBegin(GL_TRIANGLES);
        // white lines
        glColor3f(1.0f,1.0f,1.0f);
    // Front

        glVertex3f( x, y + 1, z);
        glVertex3f(x - 1, y - 1, z + 1);
        glVertex3f(x + 1, y - 1, z + 1);


        // Right

        glVertex3f(x, y + 1, z);
        glVertex3f(x + 1, y - 1, z + 1.0f);
        glVertex3f(x + 1.0f, y - 1.0f, z - 1.0f);


        // Back
        glVertex3f(x, y + 1.0f, z);
        glVertex3f(x + 1.0f, y - 1.0f, z - 1.0f);
        glVertex3f(x - 1.0f, y - 1.0f, z - 1.0f);

        // Left
        glVertex3f( x, y + 1.0f, z);
        glVertex3f(x - 1.0f,y - 1.0f,z - 1.0f);
        glVertex3f(x - 1.0f,y - 1.0f, z + 1.0f);

        // bottom
        glVertex3f(x,y,z + 1.0f);
        glVertex3f(x,y,z);
        glVertex3f(x+1.0f,y,z + 1.0f);


    glEnd();



}

// special keyboard keys interaction
void keyPressed(int key, int mouse_x, int mouse_y)
{

    switch(key)
    {
        case GLUT_KEY_UP:
            y += 0.1f;
            break;
        case GLUT_KEY_DOWN:
            y -= 0.1f;
            break;
        case GLUT_KEY_LEFT:
            x -= 0.1f;
            break;
        case GLUT_KEY_RIGHT:
            x += 0.1f;
            break;
    }
}

// keyboard letters interaction
void keyboardPressed(unsigned char key, int mouse_x, int mouse_y)
{
    switch(key)
    {
        case 'w':
            z += 0.1f;
            break;
        case 's':
            z -= 0.1f;
            break;
        case 'j':
            angle += 15.0f;
            break;
        case 'l':
            angle -= 15.0f;
            break;
        case 'i':
            angle2 += 15.0f;
            break;
        case 'k':
            angle2 -= 15.0f;
            break;
        case 'n':
            angle3 += 15.0f;
            break;
        case 'm':
            angle3 -= 15.0f;
            break;
    }
    glutPostRedisplay();
}

void mouse_motion(void){

}

void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(5.0,5.0,5.0, 
		      0.0,0.0,0.0,
			  0.0f,1.0f,0.0f);

	// axis x,y,z
	createAxis();
    
    // put the geometric transformations here
    glRotatef(angle, 0.0f,1.0f,0.0f);
    glRotatef(angle2, 1.0f,0.0f,0.0f);
    glRotatef(angle3, 0.0f,0.0f,1.0f);

// put drawing instructions here
    glPolygonMode(GL_FRONT_AND_BACK,GL_LINE);
    // x += 0.1f;
    make_pyramid();



	// End of frame
	glutSwapBuffers();
}


int main(int argc, char **argv) {

// init GLUT and the window
	glutInit(&argc, argv);
	glutInitDisplayMode(GLUT_DEPTH|GLUT_DOUBLE|GLUT_RGBA);
	glutInitWindowPosition(100,100);
	glutInitWindowSize(800,800);
	glutCreateWindow("CG@DI-UM");
		
// Required callback registry

	glutDisplayFunc(renderScene);
	glutReshapeFunc(changeSize);
	glutIdleFunc(renderScene);

	
// put here the registration of the keyboard callbacks
    // special key pressed
    // arrow up, down, left, right
    glutSpecialFunc(keyPressed);
    glutKeyboardFunc(keyboardPressed);
    //glutMouseFunc(mouse_motion);

//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	glEnable(GL_CULL_FACE);
	
// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
