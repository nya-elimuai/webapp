package org.literacyapp.dao.jpa;

import java.util.List;
import javax.persistence.NoResultException;
import org.literacyapp.dao.AllophoneDao;
import org.literacyapp.model.Allophone;

import org.springframework.dao.DataAccessException;

import org.literacyapp.model.enums.Locale;

public class AllophoneDaoJpa extends GenericDaoJpa<Allophone> implements AllophoneDao {

    @Override
    public Allophone readByValueIpa(Locale locale, String value) throws DataAccessException {
        try {
            return (Allophone) em.createQuery(
                "SELECT a " +
                "FROM Allophone a " +
                "WHERE a.locale = :locale " +
                "AND a.value = :value")
                .setParameter("locale", locale)
                .setParameter("value", value)
                .getSingleResult();
        } catch (NoResultException e) {
            logger.warn("Allophone \"" + value + "\" was not found for locale " + locale);
            return null;
        }
    }

    @Override
    public List<Allophone> readAllOrdered(Locale locale) throws DataAccessException {
        return em.createQuery(
            "SELECT n " +
            "FROM Number n " +
            "WHERE n.locale = :locale " +
            "ORDER BY n.value")
            .setParameter("locale", locale)
            .getResultList();
    }
}