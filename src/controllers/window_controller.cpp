#include "window_controller.h"

static WNDPROC originalWndProc = nullptr;

WindowController::WindowController(QObject *parent)
    : QObject(parent) {
}

HWND WindowController::getHWND(QQuickWindow *window)
{
    if (!window) return nullptr;
    return reinterpret_cast<HWND>(window->winId());
}


LRESULT CALLBACK CustomWndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam) {
    switch (message) {
    case WM_ERASEBKGND:
    {
        HDC hdc = (HDC)wParam;
        RECT rect;
        GetClientRect(hwnd, &rect);

        // Set a transparent background (alpha channel = 0)
        HBRUSH hBrush = CreateSolidBrush(RGB(0, 0, 0)); // Black color with alpha = 0
        FillRect(hdc, &rect, hBrush);
        DeleteObject(hBrush); // Clean up brush

        return 1; // Indicate that background was handled
    }
    case WM_NCHITTEST: {
        // Call the default window procedure to get the default hit test result
        LRESULT result = DefWindowProc(hwnd, message, wParam, lParam);

        // Get the cursor position
        POINT cursor;
        GetCursorPos(&cursor);

        // Get the window rectangle
        RECT window;
        GetWindowRect(hwnd, &window);




        // Adjust the window rectangle to exclude the title bar
      //  window.top += 40;

        // Check if the cursor is on the left edge of the window
        if (cursor.x >= window.left && cursor.x < window.left + 7)
        {
            // Check if the cursor is on the top-left corner of the window
            if (cursor.y >= window.top && cursor.y < window.top + 7)
            {
                // Return HTTOPLEFT to indicate that the window can be resized from the top-left corner
                result = HTTOPLEFT;
            }
            // Check if the cursor is on the bottom-left corner of the window
            else if (cursor.y < window.bottom && cursor.y >= window.bottom - 7)
            {
                // Return HTBOTTOMLEFT to indicate that the window can be resized from the bottom-left corner
                result = HTBOTTOMLEFT;
            }
            else
            {
                // Return HTLEFT to indicate that the window can be resized from the left edge
                result = HTLEFT;
            }
        }
        // Check if the cursor is on the right edge of the window
        else if (cursor.x < window.right && cursor.x >= window.right - 7)
        {
            // Check if the cursor is on the top-right corner of the window
            if (cursor.y >= window.top && cursor.y < window.top + 7)
            {
                // Return HTTOPRIGHT to indicate that the window can be resized from the top-right corner
                result = HTTOPRIGHT;
            }
            // Check if the cursor is on the bottom-right corner of the window
            else if (cursor.y < window.bottom && cursor.y >= window.bottom - 7)
            {
                // Return HTBOTTOMRIGHT to indicate that the window can be resized from the bottom-right corner
                result = HTBOTTOMRIGHT;
            }
            else
            {
                // Return HTRIGHT to indicate that the window can be resized from the right edge
                result = HTRIGHT;
            }
        }
        // Check if the cursor is on the top edge of the window
        else if (cursor.y >= window.top && cursor.y < window.top + 7)
        {
            // Return HTTOP to indicate that the window can be resized from the top edge
            result = HTTOP;
        }
        // Check if the cursor is on the bottom edge of the window
        else if (cursor.y < window.bottom && cursor.y >= window.bottom - 7)
        {
            // Return HTBOTTOM to indicate that the window can be resized from the bottom edge
            result = HTBOTTOM;
        }
        if (cursor.y >= window.top + 5 && cursor.y < window.top + 40 && cursor.x < window.right - 200)
        {
            // Return HTCAPTION to indicate that the window can be dragged and snapped
            return HTCAPTION;
        }
        // Check if the cursor is not on any of the window edges or corners


        // Return the final hit test result
        return result;
    }


    case WM_NCCALCSIZE:
        if (wParam == TRUE)
        {
            // Get the pointer to the NCCALCSIZE_PARAMS structure
            NCCALCSIZE_PARAMS* pncsp = (NCCALCSIZE_PARAMS*)lParam;

            // Get the size of the window border
            int border = GetSystemMetrics(SM_CXSIZEFRAME);

            // Adjust the window frame size to remove the border
            //qDebug() << "border" << border;
            pncsp->rgrc[0].left += 0.5;
            pncsp->rgrc[0].top += border;
            pncsp->rgrc[0].right -= 0.5;
            pncsp->rgrc[0].bottom -= 0.5;

            // Get the height of the custom title bar
            int titleBarHeight = 0;

            // Adjust the window frame position to match the custom title bar
            pncsp->rgrc[0].top += titleBarHeight - border;

            // Return 0 to indicate that the new size is valid
            return 0;
        }
        break;


    }
    return CallWindowProc(originalWndProc, hwnd, message, wParam, lParam);

    //return DefWindowProc(hwnd, message, wParam, lParam);
}


void WindowController::restoreAndMoveWindow(QQuickWindow *window) {
    qDebug() << "restoreAndMoveWindow";
    if (!window) return;
    HWND hwnd = getHWND(window);



    // Get the current window style
    LONG_PTR style = GetWindowLongPtr(hwnd, GWL_STYLE);

    // Add the WS_THICKFRAME and WS_MAXIMIZEBOX flags
    style |=  WS_THICKFRAME | WS_MAXIMIZEBOX;

    style &= ~WS_SYSMENU | ~WS_CAPTION  ;


    // Set the new window style
    SetWindowLongPtr(hwnd, GWL_STYLE, style);



    originalWndProc = reinterpret_cast<WNDPROC>(SetWindowLongPtr(hwnd, GWLP_WNDPROC, reinterpret_cast<LONG_PTR>(CustomWndProc)));


  //  SetWindowLongPtr(hwnd, GWLP_WNDPROC, reinterpret_cast<LONG_PTR>(CustomWndProc));



}

