package com.shopstyle.partner.core.service;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.scheduling.annotation.Async;

import com.shopstyle.audit.model.AuditContext;
import com.shopstyle.audit.service.AuditContexts;
import com.shopstyle.common.model.PaginatedList;
import com.shopstyle.common.model.ValidationError;
import com.shopstyle.common.model.ValidationException;
import com.shopstyle.partner.core.legacy.repository.${titleCaseObject}Repository;
import com.shopstyle.partner.model.${titleCaseObject};
import com.shopstyle.partner.service.${titleCaseObject}Service;

public class Extended${titleCaseObject}Service implements ${titleCaseObject}Service {

    private final AuditContexts auditContexts;
    private final ${titleCaseObject}Repository repository;
    private final Validator validator;

    public Extended${titleCaseObject}Service(${titleCaseObject}Repository repository,
            AuditContexts auditContexts, Validator validator) {
        this.repository = repository;
        this.auditContexts = auditContexts;
        this.validator = validator;
    }

    @Async
    @Override
    public CompletableFuture<Optional<${titleCaseObject}>> getById(Long ${camelCaseObject}Id) {
        return CompletableFuture
                .completedFuture(Optional.ofNullable(repository.findOne(${camelCaseObject}Id)));
    }

    @Override
    public CompletableFuture<${titleCaseObject}> create(${titleCaseObject} ${camelCaseObject},
            AuditContext auditCtxt) {
        try {
            auditContexts.setContext(auditCtxt);
            validate(${camelCaseObject});
            return CompletableFuture.completedFuture(repository.save(${camelCaseObject}));
        } finally {
            auditContexts.clearContext();
        }
    }

    @Async
    @Override
    public CompletableFuture<${titleCaseObject}> update(${titleCaseObject} ${camelCaseObject},
            AuditContext auditCtxt) {
        try {
            auditContexts.setContext(auditCtxt);
            ${titleCaseObject} persistedObject = repository.findOne(${camelCaseObject}.getId());
            if (persistedObject == null) {
                return null;
            }

            if (persistedObject != ${camelCaseObject}) {
                ${camelCaseObject}.copyInto(persistedObject);
            }

            validate(persistedObject);

            return CompletableFuture.completedFuture(repository.save(persistedObject));
        } finally {
            auditContexts.clearContext();
        }

    }

    @Override
    public CompletableFuture<Void> delete(Long ${camelCaseObject}Id, AuditContext auditCtxt) {
        try {
            auditContexts.setContext(auditCtxt);
            repository.delete(${camelCaseObject}Id);
            return CompletableFuture.completedFuture(null);
        } finally {
            auditContexts.clearContext();
        }
    }

    private void validate(${titleCaseObject} ${camelCaseObject}) throws ValidationException {
        Set<ConstraintViolation<${titleCaseObject}>> violations = new HashSet<>();
        violations.addAll(validator.validate(${camelCaseObject}));

        List<ValidationError> errors = violations.stream()
                .map(violation -> new ValidationError(violation.getMessage())
                        .withFieldName(violation.getPropertyPath().toString()))
                .collect(Collectors.toList());

        if (!errors.isEmpty()) {
            throw new ValidationException("Requested object is not valid", errors);
        }

    }
}