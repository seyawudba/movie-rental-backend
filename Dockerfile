FROM python:3.12.4-alpine3.19
LABEL maintainer="seyawudba"

ENV PYTHONUNBUFFERED 1


WORKDIR /src/app/

COPY . .



COPY --chown=rental-user:rental-django . .

ARG DEV=false

RUN pip install pipenv && \
    pip install psycopg2-binary && \
    python3.12 -m pip install --upgrade pip && \
    pip install -r requirements.txt && \
    if [ $DEV = "true" ]; \
        then pipenv install --dev -r requirements-dev.txt; \
    fi && \
    addgroup -g 1000 rental-django && \
    adduser \
            --disabled-password \
            --no-create-home \ 
            --uid 1000 \
            -G rental-django \
            rental-user

ENV PATH="/py/bin:$PATH"

EXPOSE 8000

USER rental-user

CMD ["sh", "-c", "python3 manage.py makemigrations && python3 manage.py migrate && python3 manage.py runserver 0.0.0.0:8000"]
