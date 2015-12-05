FROM fedora

ADD ./data /data
WORKDIR /data

RUN dnf -y upgrade
# RPM fusion repositories
RUN dnf -y install http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
# Required instalation
RUN dnf -y install numpy scipy python-matplotlib ffmpeg portaudio-devel gcc pyaudio redhat-rpm-config MySQL-python
# Extra instalation
RUN dnf -y install mysql vim git

# PIP
RUN curl https://bootstrap.pypa.io/get-pip.py | python
# Python modules
RUN pip install pydub
RUN pip install virtualenv
# Virtual environment
RUN cd && virtualenv --system-site-packages env_with_system
RUN cd && source env_with_system/bin/activate
RUN cd && pip install PyDejavu
# Deja vu
RUN cd && git clone https://github.com/worldveil/dejavu.git ./dejavu

CMD ["sh","run.sh"]
