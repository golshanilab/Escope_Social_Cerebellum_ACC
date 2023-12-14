function MakeFigure2a(varargin) 
    clear all;
    
    addpath(genpath([pwd '/fgtools/']));
    cDir = ''; 
    inpath=[cDir 'data/']; 
    outpath=[cDir ''];

    
    % Example PSTH traces for social and object
    load([inpath 'PSTH_SocObj_Traces.mat'])
   
    % Spike Trains for raster plots, epochs of interactions
    load([inpath 'Figure_Data_sess9_1-1.mat']);

    %% Default parameters
    binsize = 0.0334;
    scalor = 0:binsize:420;
    psth_scale = [-115:176]*0.033;

    %% Figure settings 
    fg77 = figure(77);
    clf;
    set(fg77, 'Position', [100 100 900 500]);
    
    DC = axesDivide([1.6 1.6 1.6 1.6],[1.6 1.6 1.6 1.6 ],[0.08 0.08 0.85 0.9], [0.4 0.4 0.3], [0.3 0.6 0.3 ])';
    DC([4, 8, 12]) = [];
    DC{3} = [DC{3}(1)+0.045 DC{3}(2) DC{3}(3)*2 DC{3}(4)];
    DC{6} = [DC{6}(1)+0.045 DC{6}(2)+0.05 DC{6}(3)*2 DC{6}(4)*0.65];
    DC{13} = [DC{13}(1)+0.0375 DC{13}(2)+0.025 DC{13}(3)*0.8 DC{13}(4)*1.75];
    for fgf = 10:12
        DC{fgf} = [DC{fgf}(1) DC{fgf}(2)+0.04 DC{fgf}(3) DC{fgf}(4)*0.7];
    end
    
    Labels = {'A','B','C', '', '', '', 'D','E','F','','','','G'}; LdPos = [-0.02,0.01];
    for i = 1:numel(DC)
        AH(i) = axes('Pos',DC{i}); hold on;     
        FigLabel(Labels{i},LdPos, 'FontWeight', 'Bold'); 
    end
   

    % Spike ratemap and estimates
    sp_t = Spike_Times_All_Social{1};
    DN_clu = sp_t(sp_t<420);                                                                        % going over each cluster                                                                   
    DN_bins_temp_norm = histcounts(DN_clu,scalor)./nanmean(histcounts(DN_clu,scalor));
    DN_bins_temp = histcounts(DN_clu,scalor)./binsize;                                              % ./nanmean(histcounts(DN_clu,scalor));
    DN_bins_temp_sm = smooth_gaussian_1d(scalor(1:end-1), DN_bins_temp, 5*binsize);                 % 10*(median(diff(ms_sysClock))));
    Z_score = (DN_bins_temp_sm-nanmean(DN_bins_temp_sm))./std(DN_bins_temp_sm);

    [theta_sig_z] = motif_triggered_theta(epochs_social(:, 1)*1000, Z_score, scalor*1000, 87, 176); %, 87, 133); 
    theta_sig_z_socc(1, 29:end) = theta_sig_z(1, :);

%     ax11 = axes('Position', [0.35 0.875 0.45 0.1]);
    axes(AH(3));
    hold off;
    plotcol = 'r';
    temp = Spike_Times_All_Social{1};
    scale = [-115:176]*0.033; % -4:0.0125:6;
    Mat_ii = nan(size(epochs_social, 1), length(scale)-1);
    for ii = 1:size(epochs_social, 1)
        temp_ii = temp-epochs_social(ii, 1);
        Mat_ii(ii, :) = smooth_gaussian_1d(scale(1:end-1), histcounts(temp_ii, scale), mean(diff(scale))*5);
    end
    hold off;
    % Mat_ii(size(epochs_social, 1)+1, :) = zeros(1, length(scale)-1);
    theta_sig_z_socc(size(epochs_social, 1)+1, :) = zeros(1, length(scale));
    % pcolor(scale(1:end-1), 0.5:size(epochs_social, 1)+0.5, Mat_ii);
    pcolor(scale(1:end), 0.5:size(epochs_social, 1)+0.5, theta_sig_z_socc);
    shading flat; % interp;
    hold on;
    plot([0 0], [-2.75 12], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2); 
    xlim([-4 6]);
    cb1 = colorbar('northoutside');
    set(cb1, 'Position', [0.6 0.75 0.05 0.01]);
    caxis([-2.75 2.75]);
    % cb1.Visible = 'off';
    set(gca,'color','none');  
    ylim([0.5 10.5]);
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca, 'YTick', [1 10]);
    set(gca,'TickLength', [0.01 0.025]*1.5);
    % text(min(get(gca, 'xlim'))-0.1*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.125*diff((get(gca, 'ylim'))),...
    %     'b', 'FontSize', 15, 'FontWeight', 'Bold');
    % hd_yl = ylabel('Epochs (#)', 'FontSize', 13, 'FontWeight', 'Normal');
    % hd_yl.Position(2) = -0.75;
    ylabel('Epochs (#)', 'FontSize', 12, 'FontWeight', 'Normal');
    AH(3).XAxis.Visible = 'off'; % remove x-axis
    FigLabel(Labels{3}, [-0.05, 0.01], 'FontWeight', 'Bold'); 
    %%
%     ax12 = axes('Position', [0.35 0.765 0.45 0.1]);
    axes(AH(6));
    hold off;
    shadedErrorBar([-115:176]*0.033, nanmean(theta_sig_z_socc), nanstd(theta_sig_z_socc)./sqrt(size(theta_sig_z_socc, 1)), {'color', [231 75 53]./255}, 0.1); % 
    hold on;
%     shadedErrorBar([-115:176]*0.033, nanmean(theta_sig_z_objj), nanstd(theta_sig_z_objj)./sqrt(size(theta_sig_z_objj, 1)), {'color', [87 87 86]./255}, 0.1); % 
    ylim([-2.75 2.75]);
    xlim([min([-115:176]*0.033) max([-115:176]*0.033)]);
    xlim([-4 6]);
    plot([0 0], [-2.75 12], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2); % get(gca, 'YLim')
    plot(get(gca, 'XLim'), [0 0], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2);
    set(gca,'color','none');  
    set(gca, 'YTick', [-2 0 2]);
    set(gca, 'XTick', [-4:2:6]);
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca,'TickLength', [0.01 0.025]*1.5);
    ylabel('Rate (Z-score)', 'FontSize', 12, 'FontWeight', 'Normal');
    xlabel('Time (sec.)', 'FontSize', 12, 'FontWeight', 'Normal');
    
    
    %%    
    load([inpath 'Combined_Dataset.mat']);
    alpha = 0.05;
    v1_Mutual = alpha>soc_DN_alll_AUC1_Mutual & ~Purkinje_ID_alll_Mutual;
    v2_Mutual = alpha>soc_DN_alll_AUC2_Mutual & ~Purkinje_ID_alll_Mutual;
    v3_Mutual = alpha>soc_DN_alll_AUC1_Mutual & Purkinje_ID_alll_Mutual;
    v4_Mutual = alpha>soc_DN_alll_AUC2_Mutual & Purkinje_ID_alll_Mutual;

    v1_Object = alpha>soc_DN_alll_AUC1_Object & ~Purkinje_ID_alll_Object;
    v2_Object = alpha>soc_DN_alll_AUC2_Object & ~Purkinje_ID_alll_Object;
    v3_Object = alpha>soc_DN_alll_AUC1_Object & Purkinje_ID_alll_Object;
    v4_Object = alpha>soc_DN_alll_AUC2_Object & Purkinje_ID_alll_Object;
    
    %% Purkinje Social Positive
    % Heatmap    
    axes(AH(7)); 
    hold off;
    postt = psth_scale>0.75 & psth_scale<1.25;
    pre = psth_scale>-2.25 & psth_scale<-1.75;
    [~, ind] = sort(nanmean(ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & v3_Mutual, postt), 2));   
    Purk_psth_neg_all = ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & v3_Mutual, :);
    pcolor(psth_scale, 1:size(Purk_psth_neg_all, 1), Purk_psth_neg_all(ind, :));
    shading  flat;
    hold on;
    plot([0 0], [0 sum(v3_Mutual)+sum(Purkinje_ID_alll_Mutual)], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2); 
    xlim([-4 6]);
    ylim([1 8])
    cb1 = colorbar('northoutside');
    set(cb1, 'Position', [0.35 0.565 0.05 0.01]);
    caxis([-1 1]);
    cb1.Visible = 'off';
    set(gca,'color','none');
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca,'TickLength', [0.01 0.025]*2.5);
    set(gca, 'YTick', [1.5:2:8.5], 'YTickLabel', [1:2:8]);
    % text(min(get(gca, 'xlim'))-0.1*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.125*diff((get(gca, 'ylim'))),...
    %     'a', 'FontSize', 15, 'FontWeight', 'Bold');
    ylabel('Purkinje (id)', 'FontSize', 12, 'FontWeight', 'Normal');
    AH(7).XAxis.Visible = 'off'; % remove x-axis
    AH(7).YDir = 'reverse';
    % text(min(get(gca, 'xlim'))-0.2*diff((get(gca, 'xlim'))), min(get(gca, 'ylim'))-0.05*diff((get(gca, 'ylim'))), 'g', 'FontSize', 14, 'FontWeight', 'Bold');
    % plot([min(psth_scale) min(psth_scale)+1], [sum(Purkinje_ID_alll_Mutual) sum(Purkinje_ID_alll_Mutual)], 'k', 'LineWidth', 2);

    % axPSTH2 = axes('Position', [0.35, 0.07, 0.25, 0.1]);
    axes(AH(10));
    hold off;
    plot(-10, 1, 'color', [155 38 22]./255);
    hold on;
    shadedErrorBar(psth_scale, nanmean(ZRateMap_SocPSTH_alll_Mutual(v3_Mutual, :)),...
        nanstd(ZRateMap_SocPSTH_alll_Mutual(v3_Mutual, :))./sqrt(sum(v3_Mutual)), {'color', [155 38 22]./255}, 0.1);
    xlim([-115*0.03 176*0.03]);
    ylim([-2.25 1.75]);
    set(gca, 'TickDir', 'out');
    AH(10).XColor = [155 38 22]./255;
    AH(10).YColor = [155 38 22]./255;
    % axPSTH2.YTick = [];
    set(gca,'TickLength', [0.01 0.025]*3);
    plot([0 0], get(gca, 'YLim'), '--', 'color', [0.7 0.7 0.7], 'LineWidth', 1);
    plot(get(gca, 'XLim'), [0 0], '--',  'color', [0.7 0.7 0.7],'LineWidth', 1);
    set(gca, 'TickDir', 'out', 'FontSize', 13); 
    % text(min(get(gca, 'xlim'))-0.18*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))), 'h', 'FontSize', 14, 'FontWeight', 'Bold');
    ylabel('Rate (Z-score)', 'FontSize', 12, 'FontWeight', 'Normal', 'color', 'k');
    xlabel('Time (sec.)', 'FontSize', 12, 'FontWeight', 'Normal', 'color', 'k');
    
    %% Purkinje cell antiSocial
    % Heatmap
    psth_scale = [-115:176]*0.033;  
    axes(AH(8));
    hold off;
    postt = psth_scale>0.75 & psth_scale<1.25;
    pre = psth_scale>-2.25 & psth_scale<-1.75;
    [~, ind] = sort(nanmean(ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & v4_Mutual, postt), 2));
    Purk_psth_neg_all = ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & v4_Mutual, :);
    P_image = [Purk_psth_neg_all(ind, :); nan(1, size(Purk_psth_neg_all(ind, :), 2))];
    pcolor(psth_scale, 1:size(P_image, 1), P_image);
    shading  flat; 
    hold on;
    plot([0 0], [0 sum(v4_Mutual)+sum(Purkinje_ID_alll_Mutual)], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2); 
    xlim([-4 6]);
    cb1 = colorbar('northoutside');  
    set(cb1, 'Position', [0.2 0.35 0.05 0.01]);
    caxis([-1 1]);
    % cb1.Visible = 'off';
    set(gca,'color','none');
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca, 'YTick', [1.5:2:8.5], 'YTickLabel', [1:2:8]);
    set(gca,'TickLength', [0.01 0.025]*2.5);
    % text(min(get(gca, 'xlim'))-0.1*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.125*diff((get(gca, 'ylim'))),...
    %     'a', 'FontSize', 15, 'FontWeight', 'Bold');
    % ylabel('Purkinje Cells (#)', 'FontSize', 9, 'FontWeight', 'Normal');
    AH(8).XAxis.Visible = 'off'; % remove x-axis
    AH(8).YDir = 'reverse';
    % text(min(get(gca, 'xlim'))-0.2*diff((get(gca, 'xlim'))), min(get(gca, 'ylim'))-0.05*diff((get(gca, 'ylim'))), 'e', 'FontSize', 14, 'FontWeight', 'Bold');
    % plot([min(psth_scale) min(psth_scale)+1], [sum(Purkinje_ID_alll_Mutual) sum(Purkinje_ID_alll_Mutual)], 'k', 'LineWidth', 2);

    axes(AH(11));
    hold off;
    plot(-10, 1, 'color', [231 75 53]./255);
    hold on;
    shadedErrorBar(psth_scale, nanmean(ZRateMap_SocPSTH_alll_Mutual(v4_Mutual, :)),...
        nanstd(ZRateMap_SocPSTH_alll_Mutual(v4_Mutual, :))./sqrt(sum(v4_Mutual)), {'color', [231 75 53]./255}, 0.1);
    xlim([-115*0.03 176*0.03]);
    ylim([-2.25 1.75]);
    set(gca, 'TickDir', 'out');
    AH(11).XColor = [231 75 53]./255;
    AH(11).YColor = [231 75 53]./255;
    set(gca,'TickLength', [0.01 0.025]*3);
    plot([0 0], get(gca, 'YLim'), '--', 'color', [0.7 0.7 0.7], 'LineWidth', 1);
    plot(get(gca, 'XLim'), [0 0], '--',  'color', [0.7 0.7 0.7],'LineWidth', 1);
    set(gca, 'TickDir', 'out', 'FontSize', 13);  
    % ylabel('Rate (Z-score)', 'FontSize', 9, 'FontWeight', 'Normal', 'color', 'k');
    % text(min(get(gca, 'xlim'))-0.1875*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))), 'f', 'FontSize', 14, 'FontWeight', 'Bold');
    xlabel('Time (sec.)', 'FontSize', 12, 'FontWeight', 'Normal', 'color', 'k');
    
    
    %% The rest of them
    % Heatmap
    axes(AH(9));
    hold off;
    postt = psth_scale>0.75 & psth_scale<1.25;
    pre = psth_scale>-2.25 & psth_scale<-1.75;
    [~, ind] = sort(nanmean(ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & ~v4_Mutual & ~v3_Mutual, postt), 2));
    Purk_psth_neg_all = ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & ~v4_Mutual & ~v3_Mutual, :);
    P_image = [Purk_psth_neg_all(ind, :); nan(1, size(Purk_psth_neg_all(ind, :), 2))];
    pcolor(psth_scale, 1:size(P_image, 1), P_image);
    shading  flat;  
    hold on;
    plot([0 0], [0 sum(~v4_Mutual & ~v3_Mutual)+sum(Purkinje_ID_alll_Mutual)], '--', 'color', [0.7 0.7 0.7], 'LineWidth', 2); 
    xlim([-4 6]);
    cb1 = colorbar('northoutside');
    % set(cb1, 'Position', [0.125 0.845 0.05 0.02]);
    set(cb1, 'Position', [0.35 0.565 0.05 0.01]);
    caxis([-1 1]);
    cb1.Visible = 'off';
    set(gca,'color','none');
    set(gca, 'TickDir', 'out', 'Box', 'off', 'FontSize', 13);
    set(gca, 'YTick', [1.5:4:size(P_image, 1)+0.5], 'YTickLabel', [1:4:size(P_image, 1)]);
    set(gca,'TickLength', [0.01 0.025]*2.5);
    % text(min(get(gca, 'xlim'))-0.1*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.125*diff((get(gca, 'ylim'))),...
    %     'a', 'FontSize', 15, 'FontWeight', 'Bold');
    % ylabel('Purkinje Cells (#)', 'FontSize', 9, 'FontWeight', 'Normal');
    LdPos = [-0.02,0.01];  
    AH(9).XAxis.Visible = 'off'; % remove x-axis
    AH(9).YDir = 'reverse';
    FigLabel(Labels{12}, [0.0001,0.025], 'FontWeight', 'Bold');  
    % text(min(get(gca, 'xlim'))-0.2*diff((get(gca, 'xlim'))), min(get(gca, 'ylim'))-0.05*diff((get(gca, 'ylim'))), 'e', 'FontSize', 14, 'FontWeight', 'Bold');
    % plot([min(psth_scale) min(psth_scale)+1], [sum(Purkinje_ID_alll_Mutual) sum(Purkinje_ID_alll_Mutual)], 'k', 'LineWidth', 2);
    
    axes(AH(12));
    hold off;
    plot(-10, 1, 'color', [231 75 53]./255);
    hold on;
    shadedErrorBar(psth_scale, nanmean(ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & ~v4_Mutual & ~v3_Mutual, :)),...
        nanstd(ZRateMap_SocPSTH_alll_Mutual(Purkinje_ID_alll_Mutual & ~v4_Mutual & ~v3_Mutual, :))./sqrt(sum(Purkinje_ID_alll_Mutual & ~v4_Mutual & ~v3_Mutual)), {'color', [244 155 127]./255}, 0.1);
    xlim([-115*0.03 176*0.03]);
    ylim([-2.25 1.75]);
    set(gca, 'TickDir', 'out');
    AH(12).XColor = [244 155 127]./255;
    AH(12).YColor = [244 155 127]./255;
    set(gca,'TickLength', [0.01 0.025]*3);
    plot([0 0], get(gca, 'YLim'), '--', 'color', [0.7 0.7 0.7], 'LineWidth', 1);
    plot(get(gca, 'XLim'), [0 0], '--',  'color', [0.7 0.7 0.7],'LineWidth', 1);
    set(gca, 'TickDir', 'out', 'FontSize', 13);  
    xlabel('Time (sec.)', 'FontSize', 12, 'FontWeight', 'Normal', 'color', 'k');
    % ylabel('Rate (Z-score)', 'FontSize', 9, 'FontWeight', 'Normal', 'color', 'k');
    % text(min(get(gca, 'xlim'))-0.1875*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))), 'f', 'FontSize', 14, 'FontWeight', 'Bold');
    
    axes(AH(13));
    hold off;
    br = bar(([sum(v3_Mutual) sum(v4_Mutual) sum(~v3_Mutual & ~v4_Mutual & Purkinje_ID_alll_Mutual)]/sum(Purkinje_ID_alll_Mutual))*100);
    br.FaceColor = 'flat';
    br.CData(1, :) = [155 38 22]./255;
    br.CData(2, :) = [231 75 53]./255;
    br.CData(3, :) = [244 155 127]./255;
    br.EdgeColor = 'none';
    br.BarWidth = 0.9;
    ylim([0 70]);
    set(gca, 'TickDir', 'out');
    set(gca,'TickLength', [0.01 0.025]*5);
    set(gca, 'Xtick', [1 2 3], 'XtickLabel', {'Soc^{+}', 'Soc^{-}', 'Other'} );
    set(gca, 'FontSize', 11, 'FontWeight', 'Normal', 'Box', 'off');
    % text(min(get(gca, 'xlim'))-0.35*diff((get(gca, 'xlim'))), max(get(gca, 'ylim'))+0.05*diff((get(gca, 'ylim'))), 'e', 'FontSize', 14, 'FontWeight', 'Bold')
    ylabel('Singnificant Units (%)', 'FontSize', 11, 'FontWeight', 'Normal');
    xtickangle(45);
    FigLabel(Labels{13}, [-0.05, 0.01], 'FontWeight', 'Bold');    
    
    
end

