package com.shopstyle.partner.client.service;

import java.util.Optional;
import java.util.concurrent.CompletableFuture;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import retrofit2.Retrofit;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.HTTP;
import retrofit2.http.POST;
import retrofit2.http.PUT;
import retrofit2.http.Path;
import retrofit2.http.Query;

import com.shopstyle.audit.model.AuditContext;
import com.shopstyle.audit.model.AuditedRequest;
import com.shopstyle.common.model.PaginatedList;
import com.shopstyle.partner.model.${titleCaseObject};
import com.shopstyle.partner.service.${titleCaseObject}Service;

import static com.shopstyle.api.client.ClientUtil.wrap;

@Service("${camelCaseObject}Service")
public class ${titleCaseObject}ServiceImpl implements ${titleCaseObject}Service {

    private final ${titleCaseObject}ServiceImpl.ClientBindings client;

    @Inject
    public ${titleCaseObject}ServiceImpl(Retrofit partnerClientRetrofit) {
        client = partnerClientRetrofit.create(${titleCaseObject}ServiceImpl.ClientBindings.class);
    }

    @Override
    public CompletableFuture<Optional<${titleCaseObject}>> getById(
            Long ${camelCaseObject}Id) {
        return wrap(client.getById(${camelCaseObject}Id));
    }

    @Override
    public CompletableFuture<PaginatedList<${titleCaseObject}>>
            getByOrganizationId(Long organizationId, int offset, int limit) {
        return wrap(client.getByOrganizationId(organizationId, offset, limit));
    }

    @Override
    public CompletableFuture<${titleCaseObject}> create(${titleCaseObject} ${camelCaseObject},
            AuditContext auditCtxt) {
        return wrap(client.create(new AuditedRequest<>(${camelCaseObject}, auditCtxt)));
    }

    @Override
    public CompletableFuture<${titleCaseObject}> update(${titleCaseObject} ${camelCaseObject},
            AuditContext auditCtxt) {
        return wrap(client.update(${camelCaseObject}.getId(),
                new AuditedRequest<>(${camelCaseObject}, auditCtxt)));
    }

    @Override
    public CompletableFuture<Void> delete(Long ${camelCaseObject}Id,
            AuditContext auditCtxt) {
        return wrap(client.delete(${camelCaseObject}Id,
                new AuditedRequest<>(null, auditCtxt)));
    }

    public interface ClientBindings {

        @GET("${camelCaseObject}s/{id}")
        CompletableFuture<Optional<${titleCaseObject}>> getById(
                @Path("id")
                Long ${camelCaseObject}Id);

        @POST("${camelCaseObject}s")
        CompletableFuture<${titleCaseObject}> create(
                @Body
                AuditedRequest<${titleCaseObject}> request);

        @PUT("${camelCaseObject}s/{id}")
        CompletableFuture<${titleCaseObject}> update(
                @Path("id")
                Long ${camelCaseObject}Id,
                @Body
                AuditedRequest<${titleCaseObject}> request);

        @HTTP(method = "DELETE", path = "${camelCaseObject}s/{id}", hasBody = true)
        CompletableFuture<Void> delete(
                @Path("id")
                Long ${camelCaseObject}Id,
                @Body
                AuditedRequest<Void> request);

    }
}