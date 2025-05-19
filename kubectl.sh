sudo apt install snapd
sudo systemctl enable --now snapd
sudo snap install microk8s   --classic   --channel=1.28
sudo usermod   -a   -G microk8s   $USER
sudo chown   -f   -R   $USER   ~/.kube
su   -   $USER
microk8s status   --wait-ready
microk8s  kubectl  get  nodes
microk8s  kubectl  get  services
echo "alias kubectl='microk8s kubectl'" >> ~/.bashrc
source ~/.bashrc
kubectl  get  nodes
