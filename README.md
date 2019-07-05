# Windows 10 家庭版启用远程连接 脚本库
> 1. 以管理员权限运行 install.bat , 安装远程服务端并启用监听
> 2. 将 rfxvmt.dll 复制到 C:/Windows/System32 目录下
> 3. 将 RDPWInst.exe 和 rdpwrap_ini_updater.bat 复制到 C:\Program Files\RDP Wrapper 目录下
> 4. 以管理员权限运行 rdpwrap_ini_updater.bat 将关系 .ini 适配文件
> 5. 重启系统, 运行 RDPCheck.exe 可以检测是否启用完成.
