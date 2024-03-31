#ifndef WINDOWCONTROLLER_H
#define WINDOWCONTROLLER_H

#include <QObject>
#include <QQuickWindow>
#include <Windows.h>

class WindowController : public QObject {
    Q_OBJECT

public:
    explicit WindowController(QObject *parent = nullptr);

    HWND getHWND(QQuickWindow *window);
    Q_INVOKABLE void restoreAndMoveWindow(QQuickWindow *window);
   // LRESULT CustomWndProc(HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam);
};
#endif // WINDOWCONTROLLER_H
