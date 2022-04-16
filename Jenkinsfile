pipeline {
    agent {
        label 'go'
    }
    tools {
        go 'Go 1.16'
    }
    options {
        timestamps()
    }
    stages{
        stage ('Build'){
            steps{
                sh '''export GOPATH=$WORKSPACE/go
                      export PATH="$PATH:$(go env GOPATH)/bin"

                      go get github.com/tools/godep
                      go get github.com/smartystreets/goconvey
                      go get github.com/GeertJohan/go.rice/rice
                      go get github.com/wickett/word-cloud-generator/wordyapi
                      go get github.com/gorilla/mux

                      sed -i "s/1.DEVELOPMENT/1.$BUILD_NUMBER/g" static/version

                      GOOS=linux GOARCH=amd64 go build -o ./artifacts/word-cloud-generator -v .

                      gzip artifacts/word-cloud-generator
                      mv artifacts/word-cloud-generator.gz artifacts/word-cloud-generator

                      ls -l artifacts/'''
            }
        }
        stage ('Nexus upload'){
            steps{
               nexusArtifactUploader artifacts: [[artifactId: 'word-cloud-generator', classifier: '', file: 'artifacts/word-cloud-generator', type: 'gz']], credentialsId: 'nexus_uploader', groupId: "jenkinsfile-build", nexusUrl: '192.168.33.90:8081/', nexusVersion: 'nexus3', protocol: 'http', repository: 'word-cloud-build', version: '1.$BUILD_NUMBER'
            }
       }
    }
}
