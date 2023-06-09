package com.example.another_back.entity;

import com.example.another_back.dto.RunningRequestDto;
import com.example.another_back.entity.enums.Status;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Running {

    @Column(name = "running_id")
    @Id
    private String id;

    @CreationTimestamp
    @Column(name = "check_date")
    private LocalDateTime checkDate;

    private Integer runningTime;
    private Float runningDistance;
    private Date createDate;
    private Integer userCalories;
    private String runningPic;
    private Float userPace;

    @Enumerated(value = EnumType.STRING)
    private Status status;
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    @OneToMany(mappedBy = "running", cascade = CascadeType.ALL)
    private List<FeedPic> feedPic = new ArrayList<>();

    @OneToMany(mappedBy = "runningHost")
    private List<WithRun> withRunList = new ArrayList<>();

    @ManyToOne(fetch = FetchType.LAZY)
    private WithRun withRun;

    @Builder
    public Running(RunningRequestDto runningRequestDto, String runningPic, User user) {
        this.id = runningRequestDto.getRunningId();
        this.user = user;
        this.runningTime = runningRequestDto.getRunningTime();
        this.runningDistance = runningRequestDto.getRunningDistance();
        this.createDate = runningRequestDto.getCreateDate();
        this.userCalories = runningRequestDto.getUserCalories();
        this.runningPic = runningPic;
        this.userPace = runningRequestDto.getUserPace();
        this.status = Status.DELETE;
    }
}
