#include <cstdio>
#include <cstdlib>
#include <chrono>

#ifdef __APPLE__
#include <GLUT/glut.h>
#else
#include <GL/glut.h>
#endif

#define _USE_MATH_DEFINES
#include <cmath>

float alfa = 0.0f, beta = 0.5f, radius = 200.0f;
float camX, camY, camZ;
int degrees = 90;
int slices;
float first_alpha, next_alpha;

float innerAnimation=0, outterAnimation=0;

void spherical2Cartesian() {

	camX = radius * cos(beta) * sin(alfa);
	camY = radius * sin(beta);
	camZ = radius * cos(beta) * cos(alfa);
}


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



void drawTree();
void drawTorus();
void drawCowboys();
void drawIndian();

void timer(int)
{
/* update animation */
    innerAnimation += 0.2f;
    outterAnimation += 0.2f;
    glutPostRedisplay();
    glutTimerFunc(500, timer, 1);
}

void renderScene(void) {

	// clear buffers
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	// set the camera
	glLoadIdentity();
	gluLookAt(camX, camY, camZ,
		0.0, 0.0, 0.0,
		0.0f, 1.0f, 0.0f);

	glColor3f(0.2f, 0.8f, 0.2f);
	glBegin(GL_TRIANGLES);
		glVertex3f(100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, 100.0f);

		glVertex3f(100.0f, 0, -100.0f);
		glVertex3f(-100.0f, 0, 100.0f);
		glVertex3f(100.0f, 0, 100.0f);
	glEnd();
	// End of frame

	// put code to draw scene in here
	srand(42);
	drawTorus();
	drawCowboys();
	drawIndian();
	drawTree();


	
	glutSwapBuffers();
}

float RandomFloat(float a, float b) {
    float random = ((float) rand()) / (float) RAND_MAX;
    float diff = b - a;
    float r = random * diff;
    return a + r;
}

void drawTree()
{
    float treeRadius = 70.f;
    slices = 20;
    int x,z;
    for (int i = 0; i < 150; i++) {
        x = RandomFloat(-60,-99);

        z =  RandomFloat(-99,99);

        glPushMatrix();
        glColor3f(0.44f, 0.35f, 0.18f);
        glTranslatef(x, 2.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(1.0f, 10.0f, slices, 20);
        glPopMatrix();

        glPushMatrix();
        glColor3f(0.15f, 0.35f, 0.17f);
        glTranslatef(x, 6.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(3.0f, rand() % 8 + 5, slices, 20);
        glPopMatrix();
    }

    for (int i = 0; i < 150; i++) {
        x = RandomFloat(60,99);

        z =  RandomFloat(-99,99);

        glPushMatrix();
        glColor3f(0.44f, 0.35f, 0.18f);
        glTranslatef(x, 2.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(1.0f, 10.0f, slices, 20);
        glPopMatrix();

        glPushMatrix();
        glColor3f(0.15f, 0.35f, 0.17f);
        glTranslatef(x, 6.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(3.0f, rand() % 8 + 5, slices, 20);
        glPopMatrix();
    }

    for (int i = 0; i < 150; i++) {
        x = RandomFloat(-99,99);

        z =  RandomFloat(99,60);

        glPushMatrix();
        glColor3f(0.44f, 0.35f, 0.18f);
        glTranslatef(x, 2.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(1.0f, 10.0f, slices, 20);
        glPopMatrix();

        glPushMatrix();
        glColor3f(0.15f, 0.35f, 0.17f);
        glTranslatef(x, 6.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(3.0f, rand() % 8 + 5, slices, 20);
        glPopMatrix();
    }

    for (int i = 0; i < 150; i++) {
        x = RandomFloat(-60,99);

        z =  RandomFloat(-60,-99);

        glPushMatrix();
        glColor3f(0.44f, 0.35f, 0.18f);
        glTranslatef(x, 2.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(1.0f, 10.0f, slices, 20);
        glPopMatrix();

        glPushMatrix();
        glColor3f(0.15f, 0.35f, 0.17f);
        glTranslatef(x, 6.0f, z);
        glRotatef(-90, 1.0f, 0.0f, 0.0f);
        glutSolidCone(3.0f, rand() % 8 + 5, slices, 20);
        glPopMatrix();
    }

}

void drawTorus()
{
    glPushMatrix();
    glColor3f(1.0f, 0.0f, 0.0f);
    glTranslatef(0.0f, 2.0f,0.0f);
    glRotatef(90, 1.0f,0.0f,0.0f);
    glutSolidTorus(2, 5, 10, 50);
    glPopMatrix();
}

void drawCowboys(){
    float radiusCowboys = 20.f;
    slices = 10;
    first_alpha =(2*M_PI)/slices;

    for (int i = 0; i < slices; i++){
       next_alpha = (i * first_alpha) + innerAnimation;

       glPushMatrix();
       glColor3f(0.0f, 0.0f, 1.0f);
       glTranslatef(sin(next_alpha)*radiusCowboys, 2.0f, cos(next_alpha)*radiusCowboys);
       glRotatef(-degrees + i * (float)(360/slices) , 0.0f,1.0f,0.0f);
       glutSolidTeapot(3);
       glPopMatrix();
   }
}



void drawIndian(){
    float radiusIndian = 50.f;
    slices = 20;
    first_alpha = (2*M_PI)/(float)slices;

    for (int i = 0; i < slices; i++){
        next_alpha = (i * first_alpha) + outterAnimation;
        glPushMatrix();
        glColor3f(1.0f, 0.0f, 0.0f);
        glTranslatef(sin(next_alpha)*radiusIndian, 2.0f, cos(next_alpha)*radiusIndian);
        glRotatef(degrees + i * (float)(360/slices), 0.0f,1.0f,0.0f);
        glutSolidTeapot(3);
        glPopMatrix();
    }
}


void processKeys(unsigned char c, int xx, int yy) {

// put code to process regular keys in here

}


void processSpecialKeys(int key, int xx, int yy) {

	switch (key) {

	case GLUT_KEY_RIGHT:
		alfa -= 0.1; break;

	case GLUT_KEY_LEFT:
		alfa += 0.1; break;

	case GLUT_KEY_UP:
		beta += 0.1f;
		if (beta > 1.5f)
			beta = 1.5f;
		break;

	case GLUT_KEY_DOWN:
		beta -= 0.1f;
		if (beta < -1.5f)
			beta = -1.5f;
		break;

	case GLUT_KEY_F1:
	    radius -= 3.0f;
		if (radius < 1.0f)
			radius = 1.0f;
		break;

	case GLUT_KEY_F2:
	    radius += 3.0f;
	    break;
	}
	spherical2Cartesian();
	glutPostRedisplay();

}


void printInfo() {

	printf("Vendor: %s\n", glGetString(GL_VENDOR));
	printf("Renderer: %s\n", glGetString(GL_RENDERER));
	printf("Version: %s\n", glGetString(GL_VERSION));

	printf("\nUse Arrows to move the camera up/down and left/right\n");
	printf("Home and End control the distance from the camera to the origin");
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

	
// Callback registration for keyboard processing
	glutKeyboardFunc(processKeys);
	glutSpecialFunc(processSpecialKeys);
    glutTimerFunc(1000.0, timer, 0);



//  OpenGL settings
	glEnable(GL_DEPTH_TEST);
	//glEnable(GL_CULL_FACE);

	spherical2Cartesian();

	printInfo();

// enter GLUT's main cycle
	glutMainLoop();
	
	return 1;
}
