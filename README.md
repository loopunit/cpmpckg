# cpmpckg
![The basic idea](https://raw.githubusercontent.com/loopunit/cpmpckg/main/doc/hotline.jpg)

For a workspace in a project, a source cache should be specified:
* CPM_SOURCE_CACHE:PATH=c:\\dev\\.cpm-cache   

Binaries, for a given configuration will be installed to:
* CPM_INSTALL_CACHE:PATH=c:\\dev\\.cpm-install-cache\\x64-Release 

The local view of the aggregator can be specified thusly:
* CPM_cpmpckg_SOURCE:PATH=c:\\projects\\loopunit\\cpmpckg 

A local view of a project can be specified as well, for example:
* CPM_imgui_app_SOURCE:PATH=c:\\projects\\loopunit\\imgui_app.cpmpckg 

