FROM tensorflow/tensorflow:1.9.0
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git libssl-dev krb5-user libsasl2-modules-gssapi-mit
RUN git clone https://github.com/edenhill/librdkafka.git
WORKDIR /notebooks/librdkafka
RUN ./configure --install-deps
RUN make
RUN make install
RUN pip install --no-binary :all: confluent-kafka
RUN pip install Flask
ADD serve-model.py /
ADD output_labels.txt /
ADD output_graph.pb /
ADD templates/main.html /templates/main.html
ADD templates/response.html /templates/response.html
RUN mkdir /static
WORKDIR /
