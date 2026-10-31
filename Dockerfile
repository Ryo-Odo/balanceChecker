FROM tomcat:9.0-jdk17-temurin AS build

WORKDIR /app

COPY src/main/java src/main/java
COPY src/main/webapp src/main/webapp

RUN mkdir -p build/classes /out/balanceChecker/WEB-INF/classes \
    && javac -encoding UTF-8 -source 17 -target 17 \
       -cp "$CATALINA_HOME/lib/servlet-api.jar:src/main/webapp/WEB-INF/lib/*" \
       -d build/classes \
       $(find src/main/java -name '*.java') \
    && cp -R src/main/webapp/. /out/balanceChecker/ \
    && cp -R build/classes/. /out/balanceChecker/WEB-INF/classes/

FROM tomcat:9.0-jdk17-temurin

RUN rm -rf "$CATALINA_HOME/webapps"/* \
    && sed -i 's/port="8080"/port="10000"/' "$CATALINA_HOME/conf/server.xml" \
    && sed -i '/<\/Host>/i\        <Valve className="org.apache.catalina.valves.RemoteIpValve" remoteIpHeader="x-forwarded-for" protocolHeader="x-forwarded-proto" />' "$CATALINA_HOME/conf/server.xml"

COPY --from=build /out/balanceChecker "$CATALINA_HOME/webapps/balanceChecker"
COPY deploy/root "$CATALINA_HOME/webapps/ROOT"

EXPOSE 10000

CMD ["catalina.sh", "run"]
