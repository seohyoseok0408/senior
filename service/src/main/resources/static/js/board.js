let index = {
    init: function() {
        $("#btn-save").on("click", () => {
            this.save();
        });
        $('.summernote').summernote({
            tabsize : 2,
            height : 300,
            placeholder : '내용을 입력하세요'
        });
    },

    save: function() {
        let data = {
            workLogContent: $("#content").val(),
            cwId: $("#cwId").val(),
            seniorId: $("#seniorId").val(),
            visitStartTime: $("#visitStartDate").val(),
            visitEndTime: $("#visitEndDate").val()
        };
        console.log(JSON.stringify(data));
        if (!data.workLogContent || !data.visitStartTime || !data.visitEndTime) {
            alert("모든 필드를 입력해주세요.");
            return;
        }

        $.ajax({
            type: "POST",
            url: "/api/board",
            data: JSON.stringify(data),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
        }).done(function(resp) {
            alert("글쓰기가 완료되었습니다.");
            location.href = "/";
        }).fail(function(error) {
            console.log(JSON.stringify(data))
            alert(JSON.stringify(error))
        });
    },
}

index.init();