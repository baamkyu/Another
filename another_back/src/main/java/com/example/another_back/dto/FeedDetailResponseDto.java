package com.example.another_back.dto;

import com.example.another_back.entity.Running;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.json.simple.JSONArray;

import java.sql.Date;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@Setter
public class FeedDetailResponseDto {
    private String runningId;
    private Long userId;
    private Integer runningTime;
    private Float runningDistance;
    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
    private Date createDate;
    private Integer walkCount;
    private Integer kcal;
    private String runningPic;
    private List<FeedPicResponsDto> feedPics;
    private JSONArray speed;

    @Builder
    public FeedDetailResponseDto(Running running) {
        this.runningId = running.getId();
        this.userId = running.getUser().getId();
        this.runningTime = running.getRunningTime();
        this.runningDistance = running.getRunningDistance();
        this.createDate = running.getCreateDate();
        this.walkCount = running.getWalkCount();
        this.kcal = running.getKcal();
        this.runningPic = running.getRunningPic();
        this.feedPics = running.getFeedPic().stream().map(FeedPicResponsDto::new).collect(Collectors.toList());
    }
}
