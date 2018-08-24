package com.shopstyle.partner.service;

import java.util.Optional;
import java.util.concurrent.CompletableFuture;

import com.shopstyle.audit.model.AuditContext;
import com.shopstyle.common.model.PaginatedList;
import com.shopstyle.partner.model.${titleCaseObject};

public interface ${titleCaseObject}Service {

    CompletableFuture<Optional<${titleCaseObject}>> getById(Long ${camelCaseObject}Id);

    CompletableFuture<${titleCaseObject}> create(${titleCaseObject} ${camelCaseObject},
        AuditContext auditCtxt);

    CompletableFuture<${titleCaseObject}> update(${titleCaseObject} ${camelCaseObject},
        AuditContext auditCtxt);

    CompletableFuture<Void> delete(Long ${camelCaseObject}Id, AuditContext auditCtxt);

}
