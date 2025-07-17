FROM kasmweb/core-kali-rolling:1.17.0
USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
ENV INST_SCRIPTS $STARTUPDIR/install
WORKDIR $HOME

######### Customize Container Here ###########

# copy over install_files/ for use in playbooks
ADD install_files $HOME/install_files

# install Ansible per 
# https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-debian
ENV UBUNTU_CODENAME jammy
RUN apt install wget gpg -y
RUN wget -O- https://archive.kali.org/archive-keyring.gpg | gpg --dearmour -o /usr/share/keyrings/ansible-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/ansible-archive-keyring.gpg] http://ppa.launchpad.net/ansible/ansible/ubuntu $UBUNTU_CODENAME main" | tee /etc/apt/sources.list.d/ansible.list
RUN apt update
RUN apt install ansible -y
RUN rm -rf /var/lib/apt/lists/*

# run Ansible commands
COPY ./requirements.yaml ./playbook.yaml ./
RUN ansible-galaxy install -r requirements.yaml && ansible-playbook -i,localhost playbook.yaml --tags "all" && rm -f ./*.yaml

# Create .profile and set XFCE terminal to use it
RUN cp /etc/skel/.profile $HOME/.profile && mkdir -p $HOME/.config/xfce4/terminal/
COPY ./terminalrc /home/kasm-default-profile/.config/xfce4/terminal/terminalrc

# clean up install_files/
RUN rm -rf $HOME/install_files/

# show disk space info
RUN df -h

######### End Customizations ###########

RUN chown 1000:0 $HOME
RUN $STARTUPDIR/set_user_permission.sh $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000
