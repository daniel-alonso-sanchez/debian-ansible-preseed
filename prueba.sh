#!/bin/bash
echo "#!/bin/bash" >> init_env.sh
echo "if [ -e $HOME/.initialized ]  " >> init_env.sh
echo "then" >> init_env.sh
echo "    echo 'No steps required' >> $HOME/salida" >> init_env.sh
echo "else" >> init_env.sh
echo "    echo 'Your steps go here' >> $HOME/salida" >> init_env.sh
echo "    docker run -v /home/usuario/ansible:/ansible/playbooks ansibled install.yml -i local_inventory" >> init_env.sh
echo "    touch $HOME/.initialized" >> init_env.sh
echo "fi" >> init_env.sh
