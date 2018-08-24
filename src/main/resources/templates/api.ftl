package com.shopstyle.partner.internal.api.resources;

import com.shopstyle.api.core.jersey.ResponseUtil;
import com.shopstyle.audit.model.AuditedRequest;
import com.shopstyle.partner.model.CampaignExpense;
import com.shopstyle.partner.model.${titleCaseObject};
import com.shopstyle.partner.service.${titleCaseObject}Service;

import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.container.AsyncResponse;
import javax.ws.rs.container.Suspended;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("${camelCaseObject}s")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ${titleCaseObject}sApi {

    @Inject
    private ${titleCaseObject}Service service;

    @GET
    @Path("/{id}")
    public void getById(
            @PathParam("id")
            Long ${camelCaseObject}Id,
            @Suspended
            AsyncResponse asyncResponse) {
        ResponseUtil.resumeResponseWhenComplete(
                service.getById(${camelCaseObject}Id)
                        .thenApply(o -> o.orElse(null)), asyncResponse);
    }

    @POST
    public void create(
            AuditedRequest<${titleCaseObject}> createRequest,
            @Suspended
	        AsyncResponse response) {
        ResponseUtil.resumeResponseWhenComplete(
                service.create(newSignUp.getPayload(), createRequest.getContext()), response);
    }

    @PUT
    @Path("/{id}")
    public void update(
            @PathParam("id")
            Long ${camelCaseObject}Id,
            AuditedRequest<${titleCaseObject}> updateRequest,
            @Suspended
            AsyncResponse response) {
        ResponseUtil.resumeResponseWhenComplete(
                service.update(
                        updateRequest.getPayload(), updateRequest.getContext()),
                response);
    }

    @DELETE
    @Path("/{id}")
    public void delete(
            @PathParam("id")
            Long ${camelCaseObject}Id,
            AuditedRequest<Void> deleteRequest,
            @Suspended
            AsyncResponse asyncResponse) {
        service.delete(${camelCaseObject}Id,
                deleteRequest.getContext()).whenComplete((ignored, tt) -> {
            if (tt != null) {
                asyncResponse.resume(tt);
            } else {
                asyncResponse.resume(Response.ok().build());
            }
        });
    }
}