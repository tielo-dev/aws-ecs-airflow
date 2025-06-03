FROM apache/airflow:2.10.1-python3.11

ENV AIRFLOW_HOME=/usr/local/airflow

USER root

#configs
COPY config/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg

#plugins
COPY plugins ${AIRFLOW_HOME}/plugins

#initial dags
COPY dags /dags
RUN mkdir ${AIRFLOW_HOME}/dags 

RUN chown -R airflow: ${AIRFLOW_HOME}
RUN chmod 777 -R /dags


USER airflow

#requirements
COPY config/requirements.txt .
RUN pip install -r requirements.txt

RUN sed -i \
    's/self\.extras\.pop("allow_insecure", "false")\.lower() == "true"/str(self.extras.pop("allow_insecure", "false")).lower() == "true"/' \
    /home/airflow/.local/lib/python3.11/site-packages/airflow/providers/mongo/hooks/mongo.py
EXPOSE 8080 5555 8793

WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]

