echo "Running $0"

echo "Got the parameters:"
echo password $password


#######################################################
##################### Configure Neo4j #################
#######################################################
wget -O /tmp/neotechnology.gpg.key http://debian.neo4j.org/neotechnology.gpg.key
rpm --import /tmp/neotechnology.gpg.key

cat <<EOF>  /etc/yum.repos.d/neo4j.repo
[neo4j]
name=Neo4j Yum Repo
baseurl=http://yum.neo4j.org/stable
enabled=1
gpgcheck=1
EOF

yum install -y neo4j

#change the config

systemctl start neo4j
