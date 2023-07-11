<h1 align="center">
<br />Titawin
</h1>
<br>
<br>
<br>


What is Titawin: Open-Source and UI-friendly tool to analyze system requirements and system configurations for windows.
<br />
<br />
![image](https://github.com/Hardenberg/titawin/assets/15233775/f633d91c-12f7-47a4-9249-e45db58a1024)
<br />
<br />

#### Build Titawin 
**Titawin** is built with <a href="https://flutter.dev/">Flutter</a>.

#### Requirements
- Flutter 3.10.5
- Windows 10
- Powershell 

### Contributing
If you like what you see here, and want to help support the work being done, you could:
+ Report Bugs
+ Request/Implement Features
+ Refactor Codebase
+ Help Write Documentation

### Configuration 

```JSON
{
    "title": "any any any any any",
    "product": "any",
    "headline": "Check your PC for",
    "test_array": [
        {
            "type": "ps",
            "execute": "(Get-WmiObject -Class Win32_ComputerSystem).SystemType",
            "compare": {
                "type": "regex",
                "operator": "any",
                "value": "x64"
            },
            "ok_text": "you have the correct Architecture",
            "not_ok_text": "You are not running the correct Architecture"
        },
        {
            "type": "ps",
            "execute": "[math]::Round(((Get-WmiObject -Class Win32_LogicalDisk -Filter \"DeviceID='C:'\").FreeSpace / 1GB), 0)",
            "compare": {
                "type": "number",
                "operator": ">=",
                "value": "2"
            },
            "ok_text": "you have enough Space",
            "not_ok_text": "You don't have enough space"
        }
    ]
}
```
#### Description
```
title: "Titawin - " + your text

headline + product -> combined
```
