#include <GLFW/glfw3.h>

#include <stdarg.h>

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main(int argc, char** argv)
{
    int windowed_x, windowed_y, windowed_width, windowed_height;
    int last_xpos = INT_MIN, last_ypos = INT_MIN;
    int last_width = INT_MIN, last_height = INT_MIN;
    int limit_aspect_ratio = false, aspect_numer = 1, aspect_denom = 1;
    int limit_min_size = false, min_width = 400, min_height = 400;
    int limit_max_size = false, max_width = 400, max_height = 400;
    char width_buffer[10] = "", height_buffer[10] = "";
    char xpos_buffer[10] = "", ypos_buffer[10] = "";
    char numer_buffer[10] = "", denom_buffer[10] = "";
    char min_width_buffer[10] = "", min_height_buffer[10] = "";
    char max_width_buffer[10] = "", max_height_buffer[10] = "";
    int may_close = true;

    if (!glfwInit())
        exit(EXIT_FAILURE);

    glfwWindowHint(GLFW_SCALE_TO_MONITOR, GLFW_TRUE);
    glfwWindowHint(GLFW_WIN32_KEYBOARD_MENU, GLFW_TRUE);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 2);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 1);

    GLFWwindow* window = glfwCreateWindow(600, 600, "Window Features", NULL, NULL);
    if (!window)
    {
        glfwTerminate();
        exit(EXIT_FAILURE);
    }

    glfwMakeContextCurrent(window);
    glfwSwapInterval(0);

    bool position_supported = true;

    glfwGetError(NULL);
    glfwGetWindowPos(window, &last_xpos, &last_ypos);
    sprintf(xpos_buffer, "%i", last_xpos);
    sprintf(ypos_buffer, "%i", last_ypos);
    if (glfwGetError(NULL) == GLFW_FEATURE_UNAVAILABLE)
        position_supported = false;

    glfwGetWindowSize(window, &last_width, &last_height);
    sprintf(width_buffer, "%i", last_width);
    sprintf(height_buffer, "%i", last_height);

    sprintf(numer_buffer, "%i", aspect_numer);
    sprintf(denom_buffer, "%i", aspect_denom);

    sprintf(min_width_buffer, "%i", min_width);
    sprintf(min_height_buffer, "%i", min_height);
    sprintf(max_width_buffer, "%i", max_width);
    sprintf(max_height_buffer, "%i", max_height);

    while (!(may_close && glfwWindowShouldClose(window)))
    {
        int width, height;

        glfwGetWindowSize(window, &width, &height);
        glfwSwapBuffers(window);

        glfwWaitEvents();
    }

    glfwTerminate();
    exit(EXIT_SUCCESS);
}
