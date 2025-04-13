<table>
    <thead>
        <tr>
            <th>Name</th>
            <th>Course</th>
            <th>Progress %</th>
            <th>Completion Status</th>
        </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${not empty progressList}">
                <c:forEach var="progress" items="${progressList}">
                    <tr>
                        <td>${progress.studentName != null ? progress.studentName : 'N/A'}</td>
                        <td>${progress.courseTitle != null ? progress.courseTitle : 'N/A'}</td>
                        <td><fmt:formatNumber value="${progress.progressPercentage}" type="number" minFractionDigits="2" maxFractionDigits="2"/>%</td>
                        <td class="${progress.completed == 1 ? 'status-completed' : 'status-in-progress'}">
                            ${progress.completed == 1 ? 'Completed' : 'In Progress'}
                        </td>
                    </tr>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="4" class="message">No student progress found.</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>