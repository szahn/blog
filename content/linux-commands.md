# Linux Commands

| Task | Command |
------ | -------
| Get size of folder | `du -h -c .` |
| Unzip multiple files | `for f in *.zip; do unzip $f -d ${f::-4}; done` |
| List processess running port | `lsof -i :port` |
| Kill a process | `kill -9 :pid` |